-- | We store items on a binary tree, moving them down the left or right branch
-- according to a coin flip. At the end, the rightmost N items on the tree are
-- selected. Each time we insert into a tree having N items, we prune its
-- leftmost item.
--
-- It may be helpful to think of this as lazily assigning each item a d-bit
-- score, where d is the maximum depth of the tree. Moving an item to the
-- left or right corresponds to appending a 0 or 1 to its score. Note that
-- the laziness is necessary, because d is not known a priori.
--
-- The process of moving items futher down the tree is herein referred to as
-- "disambiguation", because its purpose is to resolve ties in the score.

module Choose.Tree (Tree, empty, insert, applyLimit, evict, disambiguate) where

import Prelude (Bool (..), Foldable (..), Int,
                not, pure, ($), (+), (-), (.), (<$>),
                (<=), (=<<), (==))

import Control.Monad        (return)
import Control.Monad.Random (Rand, RandomGen, getRandom)


data Tree a = Nil | Tree
    { treeSize   :: Int    -- ^ Total number of items at this node and below
    , treeValues :: [a]    -- ^ Items at this node
    , treeLeft   :: Tree a -- ^ Left subtree (less likely for inclusion)
    , treeRight  :: Tree a -- ^ Right subtree (more likely for inclusion)
    }

instance Foldable Tree where

    foldr _ z Nil = z
    foldr f z (Tree size (x:xs) left right) =
        foldr f (f x z) (Tree (size - 1) xs left right)
    foldr f z (Tree size [] left right) =
        (\z -> foldr f z left) . (\z -> foldr f z right) $ z

    length Nil      = 0
    length t@Tree{} = treeSize t

    null Nil      = True
    null t@Tree{} = treeSize t == 0

empty :: Tree a
empty = Nil

-- | Trivial insertion into the root of a tree, increasing its size by 1
-- and leaving its children unmodified.
insert :: a -> Tree a -> Tree a
insert x Nil                       = Tree 1 [x] Nil Nil
insert x (Tree size xs left right) = Tree (size + 1) (x:xs) left right

-- | Remove items from the tree until its size is at most @limit@.
-- This may involve disambiguation if eviction takes place.
applyLimit :: (RandomGen g) =>
  Int -- ^ @limit@
  -> Tree a
  -> Rand g (Tree a)
applyLimit limit _ | limit <= 0 = pure Nil
applyLimit limit tree =
    -- If the tree is small enough: We don't need to do anything.
    if length tree <= limit then pure tree
    -- If the tree is oversized: Remove an item from it, and recurse.
    else applyLimit limit =<< evict tree

-- | Remove one item from the tree (or leave the tree unmodified if it is
-- already empty). This may involve disambiguation if there is not already
-- a clear leftmost item.
evict :: (RandomGen g) => Tree a -> Rand g (Tree a)
evict tree | length tree <= 1 = pure Nil
evict tree = do
    (Tree _ _ left right) <- disambiguate tree
    -- Evict from one of the subtrees, preferring to evict from the left.
    (left', right') <- if not . null $ left
                       then (\x -> (x, right)) <$> evict left
                       else (\x -> (left, x)) <$> evict right
    return $ Tree (length left' + length right') [] left' right'

-- | Perform disambiguation at the root level only, pushing items from
-- the root down into subtrees as necessary.
disambiguate :: (RandomGen g) => Tree a -> Rand g (Tree a)
-- No items at the root: No disambiguation is possible at the root level.
disambiguate tree@(Tree _ [] _ _) = pure tree
-- A single item with no children: No disambiguation is required on this tree.
disambiguate tree@(Tree _ [_] Nil Nil) = pure tree
-- There is at least one item at the root that needs to be pushed down, to
-- disambiguate it (either from items in subtrees, or from other items at
-- the root).
disambiguate (Tree size (x:xs) left right) = do
    b <- getRandom
    let (left', right') = if b
                          then (insert x left, right)
                          else (left, insert x right)
    disambiguate $ Tree size xs left' right'
