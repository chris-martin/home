{-# LANGUAGE CPP #-}

import Data.Monoid
    ( Monoid (mempty, mappend, mconcat)
    , Endo (Endo, appEndo), Sum (Sum, getSum), Product (Product, getProduct)
    )

import Data.Foldable
    ( Foldable (foldMap, foldr, foldl, null, length, elem)
    , traverse_, for_, sequenceA_, asum, mapM_, forM_, sequence_
    , and, or, any, all, find
    )

import Data.Traversable
    ( Traversable (traverse, sequenceA, mapM, sequence)
    , for, forM, mapAccumL, mapAccumR
    )

import Control.Applicative
    ( Applicative ((<*>), (*>), (<*), pure), liftA, liftA2, liftA3
    , Alternative (empty, (<|>), some, many), optional
    , Const (Const, getConst), ZipList (ZipList, getZipList)
    )

import Control.Monad
    ( Monad ((>>=), (>>), return, fail), (=<<), (>=>), (<=<), (<$!>)
    , MonadPlus (mzero, mplus), msum, mfilter
    , mapM, mapM_, forM, forM_, sequence, sequence_
    , forever, join, filterM, foldM, foldM_
    , replicateM, replicateM_, guard, when, unless
    )

import Prelude
    ( even, odd, gcd, lcm, (^), (^^)
    , putChar, putStr, putStrLn, print
    )

import Data.Bool (Bool (True, False), (&&), (||), otherwise, not)
import Data.Either (Either (Left, Right), either)
import Data.Eq (Eq ((==), (/=)))
import Data.Functor (Functor (fmap, (<$)), ($>), (<$>), void)
import Data.Maybe (Maybe (Just, Nothing), maybe, isJust, isNothing)
import Numeric.Natural (Natural)
import Data.Ord (Ord (compare, (<), (<=), (>), (>=), max, min))
import Data.Semigroup (Semigroup ((<>), sconcat, stimes))
import System.IO (IO)

#ifdef MIN_VERSION_async
import           Control.Concurrent.Async (Async)
import qualified Control.Concurrent.Async as Async
#endif

#ifdef MIN_VERSION_bytestring
import           Data.ByteString (ByteString)
import qualified Data.ByteString as BS

import qualified Data.ByteString.Lazy as LBS
#endif

#ifdef MIN_VERSION_cassava
import qualified Data.Csv as Csv
#endif

#ifdef MIN_VERSION_containers
import           Data.Sequence (Seq)
import qualified Data.Sequence as Seq

import           Data.Set (Set)
import qualified Data.Set as Set

import           Data.Map (Map)
import qualified Data.Map as Map
#endif

#ifdef MIN_VERSION_path
import           Path (Path)
import qualified Path
#endif

#ifdef MIN_VERSION_path_io
import qualified Path.IO as PathIO
#endif

#ifdef MIN_VERSION_pipes
import qualified Pipes
#endif

#ifdef MIN_VERSION_retry
import qualified Control.Retry as Retry
#endif

#ifdef MIN_VERSION_stm
import qualified Control.Concurrent.STM as STM

import           Control.Concurrent.STM.TBQueue
    ( TBQueue, newTBQueue, newTBQueueIO, readTBQueue, tryReadTBQueue
    , peekTBQueue, tryPeekTBQueue, writeTBQueue, unGetTBQueue
    , isEmptyTBQueue, isFullTBQueue
    )
import qualified Control.Concurrent.STM.TBQueue as TBQueue

import           Control.Concurrent.STM.TChan
    ( TChan, newTChan, newTChanIO, newBroadcastTChan, newBroadcastTChanIO
    , dupTChan, cloneTChan, readTChan, tryReadTChan, peekTChan, tryPeekTChan
    , writeTChan, unGetTChan, isEmptyTChan
    )
import qualified Control.Concurrent.STM.TChan as TChan

import           Control.Concurrent.STM.TVar
    ( TVar, newTVar, newTVarIO, readTVar, readTVarIO, writeTVar
    , modifyTVar, modifyTVar', swapTVar
    )
import qualified Control.Concurrent.STM.TVar as TVar
#endif

#ifdef MIN_VERSION_unordered_containers
import           Data.HashSet (HashSet)
import qualified Data.HashSet as HashSet

import           Data.HashMap.Lazy (HashMap)
import qualified Data.HashMap.Lazy as HashMap

import qualified Data.HashMap.Strict as HashMap'
#endif

#ifdef MIN_VERSION_vector
import           Data.Vector (Vector)
import qualified Data.Vector as Vector
#endif

#ifdef MIN_VERSION_unordered_containers
type HashMap' = HashMap'.HashMap
#endif
