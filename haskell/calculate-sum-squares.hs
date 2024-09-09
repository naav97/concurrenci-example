import Control.Concurrent (forkIO, threadDelay, MVar, newEmptyMVar, putMVar, takeMVar)
import Control.Monad (forM_, mapM_)

sum_of_squares :: Int -> Int -> Int -> Int
sum_of_squares num i count
  | i > num = count
  | otherwise = sum_of_squares num (i + 1) (count + (i * i))

sum_from_to :: Int -> Int -> Int -> Int
sum_from_to i end re
  | i > end = re
  | otherwise = sum_from_to (i + 1) end (re + sum_of_squares i 0 0)

run :: Int -> Int -> MVar Int -> IO ()
run start end values = do
  let result = sum_from_to start end 0
  putMVar values result
  putStrLn $ "Sum of squares from " ++ show start ++ " to " ++ show end ++ " is " ++ show result ++ "!"

main :: IO ()
main = do
  let ranges = [(100, 200), (201, 300), (301, 400), (401, 500), (501, 600)]
  values <- mapM (\_ -> newEmptyMVar) ranges
  mapM_ (\((start, end), values) -> forkIO $ run start end values) (zip ranges values)
  results <- mapM takeMVar values
  let total = sum results
  putStrLn $ "Total Sum is: " ++ show total
