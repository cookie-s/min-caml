%{
    (* parserが利用する変数・関数・型の定義  *)
    open Syntax
    open Lexing
    let add_type x = (x, Type.gen_type ())
    let gen_fun = Id.gen_id "fun"
%}

/* 字句を表すデータ型  */
%token <bool> BOOL
%token <int> INT
%token <float> FLOAT
%token NOT
%token MINUS
%token PLUS
%token AST
%token SLASH
%token XOR
%token OR
%token AND
%token SLL
%token SRL
%token MINUS_DOT
%token PLUS_DOT
%token AST_DOT
%token SLASH_DOT
%token EQUAL
%token LESS_GREATER
%token LESS_EQUAL
%token GREATER_EQUAL
%token LESS
%token GREATER
%token INPUT
%token OUTPUT
%token IF
%token THEN
%token ELSE
%token <Id.t> IDENT
%token LET
%token IN
%token REC
%token FUN
%token COMMA
%token ARRAY_CREATE
%token I2F
%token F2I
%token SQRT
%token FABS
%token DOT
%token LESS_MINUS
%token MINUS_GREATER
%token SEMICOLON
%token LPAREN
%token RPAREN
%token EOF

/* 優先順位  */
%nonassoc IN
%right prec_let
%right SEMICOLON
%right prec_if
%right LESS_MINUS
%nonassoc prec_tuple
%left COMMA
%left EQUAL LESS_GREATER MINUS_GREATER LESS GREATER LESS_EQUAL GREATER_EQUAL
%left PLUS MINUS PLUS_DOT MINUS_DOT
%left AST SLASH AST_DOT SLASH_DOT
%left XOR OR AND
%left SLL SRL
%right prec_unary_minus
%left prec_app
%left DOT

/* 開始記号 */
%type <Syntax.t> exp
%start exp

%%

/* 括弧をつけなくても関数の引数になれるもの */
simple_exp:
| LPAREN exp RPAREN
    { $2 }
| LPAREN RPAREN
    { Unit }
| BOOL
    { Bool($1) }
| INT
    { Int($1) }
| FLOAT
    { Float($1) }
| IDENT
    { Var($1) }
| simple_exp DOT LPAREN exp RPAREN
    { Get($1, $4) }

/* 一般の式 */
exp:
| simple_exp
    { $1 }
| NOT exp
    %prec prec_app
    { Not($2) }
| MINUS exp
    %prec prec_unary_minus
    { match $2 with
    | Float(f) -> Float(-.f)
    | e -> Neg(e) }
| exp PLUS exp
    { Add($1, $3) }
| exp MINUS exp
    { Sub($1, $3) }
| exp AST exp
    { Mul($1, $3) }
| exp SLASH exp
    { Div($1, $3) }
| exp XOR exp
    { Xor($1, $3) }
| exp OR exp
    { Or($1, $3) }
| exp AND exp
    { And($1, $3) }
| exp SLL exp
    { Sll($1, $3) }
| exp SRL exp
    { Srl($1, $3) }
| exp EQUAL exp
    { Eq($1, $3) }
| exp LESS_GREATER exp
    { Not(Eq($1, $3)) }
| exp LESS exp
    { Not(LE($3, $1)) }
| exp GREATER exp
    { Not(LE($1, $3)) }
| exp LESS_EQUAL exp
    { LE($1, $3) }
| exp GREATER_EQUAL exp
    { LE($3, $1) }
| IF exp THEN exp ELSE exp
    %prec prec_if
    { If($2, $4, $6) }
| MINUS_DOT exp
    %prec prec_unary_minus
    { FNeg($2) }
| exp PLUS_DOT exp
    { FAdd($1, $3) }
| exp MINUS_DOT exp
    { FSub($1, $3) }
| exp AST_DOT exp
    { FMul($1, $3) }
| exp SLASH_DOT exp
    { FDiv($1, $3) }
| LET IDENT EQUAL exp IN exp
    %prec prec_let
    { Let(add_type $2, $4, $6) }
| LPAREN LET IDENT EQUAL exp RPAREN
    %prec prec_let
    { LetDef(add_type $3, $5) }
| LET REC fun_def IN exp
    %prec prec_let
    { LetRec($3, $5) }
| LPAREN LET REC fun_def RPAREN
    %prec prec_let
    { LetRecDef($4) }
| FUN formal_args MINUS_GREATER exp
    %prec prec_let
    {
    let fun_name = gen_fun in
    let fun_and_type = add_type fun_name in
      LetRec({ name = fun_and_type; args = $2; body = $4}, Var(fun_name))
    }
| simple_exp actual_args
    %prec prec_app
    { App($1, $2) }
| elems
    %prec prec_tuple
    { Tuple($1) }
| LET LPAREN pat RPAREN EQUAL exp IN exp
    { LetTuple($3, $6, $8) }
| simple_exp DOT LPAREN exp RPAREN LESS_MINUS exp
    { Put($1, $4, $7) }
| exp SEMICOLON exp
    { Let((Id.gen_tmp Type.Unit, Type.Unit), $1, $3) }
| exp SEMICOLON
    { $1 }
| ARRAY_CREATE simple_exp simple_exp
    %prec prec_app
    { Array($2, $3) }
| I2F simple_exp
    %prec prec_app
    { I2F($2) }
| F2I simple_exp
    %prec prec_app
    { F2I($2) }
| SQRT simple_exp
    %prec prec_app
    { SQRT($2) }
| FABS simple_exp
    %prec prec_app
    { FABS($2) }
| INPUT simple_exp
    %prec prec_app
    { In($2) }
| OUTPUT simple_exp
    %prec prec_app
    { Out($2) }
| error
    { failwith
        (Printf.sprintf "parse error line %d, characters %d-%d"
            (let pos = Parsing.symbol_start_pos () in pos.pos_lnum)
            (Parsing.symbol_start ())
            (Parsing.symbol_end ()))
    }

fun_def:
| IDENT formal_args EQUAL exp
    { { name = add_type $1; args = $2; body = $4 } }

formal_args:
| IDENT formal_args
    { add_type $1 :: $2 }
| IDENT
    { [add_type $1] }

actual_args:
| actual_args simple_exp
    %prec prec_app
    { $1 @ [$2] }
| simple_exp
    %prec prec_app
    { [$1] }

elems:
| elems COMMA exp
    { $1 @ [$3] }
| exp COMMA exp
    { [$1; $3] }

pat:
| pat COMMA IDENT
    { $1 @ [add_type $3] }
| IDENT COMMA IDENT
    { [add_type $1; add_type $3] }

