{-# LANGUAGE CPP #-}

import Control.Applicative
    ( Applicative ((<*>), (*>), (<*), pure), liftA, liftA2, liftA3
    , Alternative (empty, (<|>), some, many), optional
    , Const (Const, getConst), ZipList (ZipList, getZipList)
    )
import qualified Control.Applicative as Applicative

import Control.Monad
    ( Monad ((>>=), (>>), return, fail), (=<<), (>=>), (<=<), (<$!>)
    , MonadPlus (mzero, mplus), msum, mfilter
    , mapM, mapM_, forM, forM_, sequence, sequence_
    , forever, join, filterM, foldM, foldM_
    , replicateM, replicateM_, guard, when, unless
    )
import qualified Control.Monad as Monad

import Data.Bool (Bool (True, False), (&&), (||), otherwise, not)
import qualified Data.Bool as Bool

import Data.Coerce (Coercible, coerce)

import Data.Either (Either (Left, Right), either)
import qualified Data.Either as Either

import Data.Eq (Eq ((==), (/=)))
import qualified Data.Eq as Eq

import Data.Foldable
    ( Foldable (fold, foldMap, foldr, foldr', foldl, foldl', null, length, elem)
    , traverse_, for_, sequenceA_, asum, mapM_, forM_, sequence_
    , and, or, any, all, find
    )
import qualified Data.Foldable as Foldable

import Data.Function ((.), ($), (&), id)
import qualified Data.Function as Function

import Data.Functor (Functor (fmap, (<$)), ($>), (<$>), void)
import qualified Data.Functor as Functor

import Data.Functor.Identity (Identity (runIdentity))

import Data.Int (Int, Int8, Int16, Int32, Int64)

import Data.List (intercalate, intersperse, sort, zip)
import qualified Data.List as List

import Data.List.NonEmpty (NonEmpty ((:|)))
import qualified Data.List.NonEmpty as NonEmpty

import Data.Maybe (Maybe (Just, Nothing), maybe, isJust, isNothing)
import qualified Data.Maybe as Maybe

import Data.Monoid
    ( Monoid (mempty, mappend, mconcat)
    , Endo (Endo, appEndo), Sum (Sum, getSum), Product (Product, getProduct)
    )
import qualified Data.Monoid as Monoid

import Data.Ord (Ord (compare, (<), (<=), (>), (>=), max, min))
import qualified Data.Ord as Ord

import Data.Semigroup (Semigroup ((<>), sconcat, stimes))
import qualified Data.Semigroup as Semigroup

import Data.Traversable
    ( Traversable (traverse, sequenceA, mapM, sequence)
    , for, forM, mapAccumL, mapAccumR
    )
import qualified Data.Traversable as Traversable

import qualified Data.Tuple as Tuple

import Data.Word (Word, Word8, Word16, Word32, Word64)
import qualified Data.Word as Word

import Numeric.Natural (Natural)

import Prelude
    ( even, odd, gcd, lcm, (^), (^^)
    , putChar, putStr, putStrLn, print
    , Show (show), undefined
    )
import qualified Prelude

import System.IO (IO)
import qualified System.IO as IO

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_async
import Control.Concurrent.Async
    ( Async, Concurrently (Concurrently, runConcurrently)

    -- Spawning
    , async, asyncBound, asyncOn
    , asyncWithUnmask, asyncOnWithUnmask

    -- Spawning with automatic cancelation
    , withAsync, withAsyncBound, withAsyncOn
    , withAsyncWithUnmask, withAsyncOnWithUnmask

    -- Pairs of threads
    , race, race_
    , concurrently, concurrently_

    -- Arbitrary numbers of threads
    , mapConcurrently, mapConcurrently_
    , forConcurrently, forConcurrently_
    , replicateConcurrently, replicateConcurrently_
    )
import qualified Control.Concurrent.Async as Async
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_bytestring
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS

import qualified Data.ByteString.Lazy as LBS
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_cassava
import qualified Data.Csv as Csv
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_containers
import Data.Sequence (Seq)
import qualified Data.Sequence as Seq

import Data.Set (Set)
import qualified Data.Set as Set

import Data.Map (Map)
import qualified Data.Map as Map
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_path
import Path (Path)
import qualified Path
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_path_io
import qualified Path.IO as PathIO
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_pipes
import qualified Pipes
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_retry
import qualified Control.Retry as Retry
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_stm
import qualified Control.Concurrent.STM as STM

import Control.Concurrent.STM.TBQueue
    ( TBQueue, newTBQueue, newTBQueueIO, readTBQueue, tryReadTBQueue
    , peekTBQueue, tryPeekTBQueue, writeTBQueue, unGetTBQueue
    , isEmptyTBQueue, isFullTBQueue
    )
import qualified Control.Concurrent.STM.TBQueue as TBQueue

import Control.Concurrent.STM.TChan
    ( TChan, newTChan, newTChanIO, newBroadcastTChan, newBroadcastTChanIO
    , dupTChan, cloneTChan, readTChan, tryReadTChan, peekTChan, tryPeekTChan
    , writeTChan, unGetTChan, isEmptyTChan
    )
import qualified Control.Concurrent.STM.TChan as TChan

import Control.Concurrent.STM.TVar
    ( TVar, newTVar, newTVarIO, readTVar, readTVarIO, writeTVar
    , modifyTVar, modifyTVar', swapTVar
    )
import qualified Control.Concurrent.STM.TVar as TVar
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_unordered_containers
import Data.HashSet (HashSet)
import qualified Data.HashSet as HashSet

import Data.HashMap.Lazy (HashMap)
import qualified Data.HashMap.Lazy as HashMap

import qualified Data.HashMap.Strict as HashMap'
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_lucid
import qualified Lucid
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_transformers
import Control.Monad.Trans.Class (MonadTrans (lift))

import Control.Monad.Trans.Reader (ReaderT (runReaderT), Reader)
import qualified Control.Monad.Trans.Reader as Reader

import Control.Monad.Trans.State (StateT (runStateT), State)
import qualified Control.Monad.Trans.State as State
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_vector
import Data.Vector (Vector)
import qualified Data.Vector as Vector
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_wai
import qualified Network.Wai as Wai
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_warp
import qualified Network.Wai.Handler.Warp as Warp
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_unordered_containers
type HashMap' = HashMap'.HashMap
#endif
