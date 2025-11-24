module Ast where

data Expr = Plus Expr Expr
          | Minus Expr Expr
          | Times Expr Expr
          | Div Expr Expr
          | Literal Float


eval :: Expr -> Float
eval (Literal x)   = x
eval (Plus a b)    = eval a + eval b
eval (Minus a b)   = eval a - eval b
eval (Times a b)   = eval a * eval b
eval (Div a b)     = eval a / eval b

eq :: Expr -> Expr -> Bool
eq (Literal x)   (Literal y)   = x == y
eq (Plus a b)    (Plus c d)    = eq a c && eq b d
eq (Minus a b)   (Minus c d)   = eq a c && eq b d
eq (Times a b)   (Times c d)   = eq a c && eq b d
eq (Div a b)     (Div c d)     = eq a c && eq b d
eq _ _ = False


test1 = Plus (Literal 3.0) (Literal 2.0)

test2 = Plus (Literal 3.0) (Div (Literal 1.0) (Literal 2.0))

test3 = Plus (Times (Literal 3.0) (Literal 5.0)) (Div (Literal 1.0) (Literal 2.0))
