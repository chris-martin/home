{-# LANGUAGE CPP #-}

module MyFavoriteImports where

import Control.Applicative
    ( Applicative ((<*>), (*>), (<*), pure), liftA, liftA2, liftA3
    , Alternative (empty, (<|>), some, many), optional
    , Const (Const, getConst), ZipList (ZipList, getZipList)
    )
import qualified Control.Applicative as Applicative

import Control.Concurrent
    ( ThreadId, myThreadId, killThread, yield, threadDelay

    -- Forking new Haskell threads
    , forkIO, forkFinally, forkIOWithUnmask, forkOn, forkOnWithUnmask

    -- Waiting on file desriptors
    , threadWaitRead, threadWaitWrite
    , threadWaitReadSTM, threadWaitWriteSTM

    -- Haskell threads bound to operating system threads
    , forkOS, forkOSWithUnmask
    , isCurrentThreadBound, runInBoundThread, runInUnboundThread
    )
import qualified Control.Concurrent as Concurrent

import Control.Exception
    ( SomeException (SomeException), SomeAsyncException, AsyncException
    , Exception (toException, fromException, displayException)
    , IOException, ArithException, ArrayException, AssertionFailed
    , evaluate, mapException, assert

    -- Throwing exceptions
    , throw, throwIO, ioError, throwTo

    -- Masking async exceptions
    , MaskingState (Unmasked, MaskedInterruptible, MaskedUninterruptible)
    , getMaskingState, interruptible, allowInterrupt
    )
import qualified Control.Exception as Exception

import Control.Monad
    ( Monad ((>>=), (>>), return, fail), (=<<), (>=>), (<=<), (<$!>)
    , MonadPlus (mzero, mplus), msum, mfilter
    , mapM, mapM_, forM, forM_, sequence, sequence_
    , forever, join, filterM, foldM, foldM_
    , replicateM, replicateM_, guard, when, unless
    )
import qualified Control.Monad as Monad

import Control.Monad.IO.Class (MonadIO (liftIO))

import Data.Bool (Bool (True, False), (&&), (||), otherwise, not)
import qualified Data.Bool as Bool

import Data.Coerce (Coercible, coerce)

import Data.Char (Char)
import qualified Data.Char as Char

import Data.Either (Either (Left, Right), either)
import qualified Data.Either as Either

import Data.Eq (Eq ((==), (/=)))
import qualified Data.Eq as Eq

import Data.Foldable
    ( Foldable (fold, foldMap, foldr, foldr', foldl, foldl', null, length, elem)
    , traverse_, for_, sequenceA_, asum, mapM_, forM_, sequence_
    , and, or, any, all, find, minimum, maximum
    )
import qualified Data.Foldable as Foldable

import Data.Function ((.), ($), (&), id, const)
import qualified Data.Function as Function

import Data.Functor (Functor (fmap, (<$)), ($>), (<$>), void)
import qualified Data.Functor as Functor

import Data.Functor.Identity (Identity (runIdentity))

import Data.Int (Int, Int8, Int16, Int32, Int64)

import Data.IORef
    ( IORef, newIORef, mkWeakIORef
    , readIORef, writeIORef
    , modifyIORef, modifyIORef'
    , atomicModifyIORef, atomicModifyIORef'
    )

import Data.List
    ( intercalate, intersperse, sort, drop, take, repeat
    , zip, zipWith, zipWith3, zipWith4, zipWith5, zipWith6, zipWith7
    )
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

import Data.Semigroup ( Semigroup ((<>), sconcat, stimes)
                      , Min (Min, getMin), Max (Max, getMax)
                      )
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
    , putChar, putStr, putStrLn, print, ($!)
    , String, Show (show), undefined, error
    , Enum ( succ, pred, toEnum, fromEnum
           , enumFrom, enumFromThen, enumFromTo, enumFromThenTo)
    , Integer, Float, Double
    , Num ((+), (-), (*), negate, abs, signum, fromInteger)
    , Real (toRational)
    , Integral (quot, rem, div, mod, quotRem, divMod, toInteger)
    , RealFrac (properFraction, truncate, round, ceiling, floor)
    , Fractional ((/), recip, fromRational)
    , Floating ( pi, exp, log, sqrt, (**), logBase
               , sin, cos, tan , asin, acos, atan
               , sinh, cosh, tanh, asinh, acosh, atanh )
    )
import qualified Prelude

import System.IO (IO, hPutStrLn, stdin, stdout, stderr)
import qualified System.IO as IO

import Unsafe.Coerce (unsafeCoerce)

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

#ifdef MIN_VERSION_exceptions
import Control.Monad.Catch (MonadThrow (throwM), MonadCatch (catch))
import qualified Control.Monad.Catch
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_haskell_src_exts
import qualified Language.Haskell.Exts
import qualified Language.Haskell.Exts as Haskell
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_hedgehog
import Hedgehog.Gen (Gen)
import Hedgehog.Range (Range)
import qualified Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_lens
import Control.Lens ((<&>), (^.))
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_lucid
import qualified Lucid
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_network
import Network.Socket (Socket)
import qualified Network.Socket
import qualified Network.Socket as Socket
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

#ifdef MIN_VERSION_resourcet
import Control.Monad.Trans.Resource
    ( ResourceT, ResIO, ReleaseKey, runResourceT )
import qualified Control.Monad.Trans.Resource as Resource
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_retry
import qualified Control.Retry as Retry
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_safe_exceptions
import qualified Control.Exception.Safe as SafeException

import Control.Exception.Safe
    ( try, tryJust, finally, onException
    , bracket, bracket_, bracketOnError, bracketOnError_

    , MonadMask (mask, uninterruptibleMask), mask_, uninterruptibleMask_
    )
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_stm
import Control.Concurrent.STM (atomically)
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

import Control.Concurrent.STM.TMVar
    ( TMVar, newTMVar, newEmptyTMVar, newTMVarIO, newEmptyTMVarIO
    , takeTMVar, putTMVar, readTMVar, tryReadTMVar, swapTMVar
    , tryTakeTMVar, tryPutTMVar, isEmptyTMVar, mkWeakTMVar
    )
import qualified Control.Concurrent.STM.TMVar as TMVar

import Control.Concurrent.STM.TVar
    ( TVar, newTVar, newTVarIO, readTVar, readTVarIO, writeTVar
    , modifyTVar, modifyTVar', swapTVar
    )
import qualified Control.Concurrent.STM.TVar as TVar
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_text
import Data.Text (Text)

import qualified Data.Text as Text
import qualified Data.Text.IO as TextIO
import qualified Data.Text.Lazy as LText
import qualified Data.Text.Lazy.IO as LTextIO
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_time
import Data.Time.Clock (UTCTime, getCurrentTime)

import Data.Time.LocalTime (utcToLocalTime, utc, localTimeOfDay)
import qualified Data.Time.LocalTime as LocalTime

import Data.Time.Clock.POSIX
    ( POSIXTime, posixDayLength, posixSecondsToUTCTime
    , utcTimeToPOSIXSeconds, getPOSIXTime
    )
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

#ifdef MIN_VERSION_twitter_conduit
import qualified Web.Twitter.Conduit as TwitterConduit
#endif

--------------------------------------------------------------------------------

#ifdef MIN_VERSION_twitter_types
import qualified Web.Twitter.Types as Twitter
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
