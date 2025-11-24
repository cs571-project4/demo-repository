module Password where

newtype PwdOp a = PwdOp { runOp :: String -> (a, String) }

instance Functor PwdOp where
    fmap f (PwdOp g) = PwdOp (\s -> let (a, s') = g(s) in (f a, s'))

instance Applicative PwdOp where
    pure x = PwdOp (\s -> (x, s))
    (PwdOp f) <*> (PwdOp g) =
        PwdOp (\s -> let (h, s1) = f s
                         (a, s2) = g s1
                      in (h a, s2))

instance Monad PwdOp where
    (PwdOp g) >>= f =
        PwdOp (\s -> let (a, s1) = g s
                         PwdOp h = f a
                      in h s1)


setPassword :: String -> PwdOp ()
setPassword pwd = PwdOp (\_ -> ((), pwd))


checkPassword :: String -> PwdOp Bool
checkPassword attempt =
    PwdOp (\pwd -> (attempt == pwd, pwd))


runPwdOp :: PwdOp a -> a
runPwdOp (PwdOp f) = fst (f "")
