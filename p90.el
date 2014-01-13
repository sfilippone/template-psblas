;;; f90.el --- Fortran-90 mode (free format)

;; Copyright (C) 1995, 1996, 1997, 2000, 2001, 2002, 2003, 2004, 2005,
;;   2006, 2007, 2008, 2009, 2010  Free Software Foundation, Inc.

;; Author: Torbj\"orn Einarsson <Torbjorn.Einarsson@era.ericsson.se>
;; Maintainer: Glenn Morris <rgm@gnu.org>
;; Keywords: fortran, f90, languages

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Major mode for editing F90 programs in FREE FORMAT.
;; The minor language revision F95 is also supported (with font-locking).
;; Some/many (?) aspects of F2003 are supported.

;; Knows about continuation lines, named structured statements, and other
;; features in F90 including HPF (High Performance Fortran) structures.
;; The basic feature provides accurate indentation of F90 programs.
;; In addition, there are many more features like automatic matching of all
;; end statements, an auto-fill function to break long lines, a join-lines
;; function which joins continued lines, etc.

;; To facilitate typing, a fairly complete list of abbreviations is provided.
;; All abbreviations begin with the backquote character "`"
;; For example, `i expands to integer (if abbrev-mode is on).

;; There are two separate features for altering the appearance of code:
;;   1) Upcasing or capitalizing of all keywords.
;;   2) Colors/fonts using font-lock-mode.
;; Automatic upcase or downcase of keywords is controlled by the variable
;; f90-auto-keyword-case.

;; The indentations of lines starting with ! is determined by the first of the
;; following matches (values in the left column are the defaults):

;; start-string/regexp  indent         variable holding start-string/regexp
;;    !!!                  0
;;    !hpf\\$ (re)         0              p90-directive-comment-re
;;    !!$                  0              p90-comment-region
;;    !      (re)        as code          p90-indented-comment-re
;;    default            comment-column

;; Ex: Here is the result of 3 different settings of p90-indented-comment-re
;;     p90-indented-comment-re  !-indentation      !!-indentation
;;          !                    as code             as code
;;          !!                   comment-column      as code
;;          ![^!]                as code             comment-column
;; Trailing comments are indented to comment-column with indent-for-comment.
;; The function p90-comment-region toggles insertion of
;; the variable p90-comment-region in every line of the region.

;; One common convention for free vs. fixed format is that free format files
;; have the ending .p90 or .f95 while fixed format files have the ending .f.
;; Emacs automatically loads Fortran files in the appropriate mode based
;; on extension. You can modify this by adjusting the variable auto-mode-alist.
;; For example:
;; (add-to-list 'auto-mode-alist '("\\.f\\'" . p90-mode))

;; Once you have entered p90-mode, you may get more info by using
;; the command describe-mode (C-h m). For online help use
;; C-h f <Name of function you want described>, or
;; C-h v <Name of variable you want described>.

;; To customize p90-mode for your taste, use, for example:
;; (you don't have to specify values for all the parameters below)
;;
;;(add-hook 'p90-mode-hook
;;      ;; These are the default values.
;;      '(lambda () (setq p90-do-indent 3
;;                        p90-if-indent 3
;;                        p90-type-indent 3
;;                        p90-program-indent 2
;;                        p90-continuation-indent 5
;;                        p90-comment-region "!!$"
;;                        p90-directive-comment-re "!hpf\\$"
;;                        p90-indented-comment-re "!"
;;                        p90-break-delimiters "[-+\\*/><=,% \t]"
;;                        p90-break-before-delimiters t
;;                        p90-beginning-ampersand t
;;                        p90-smart-end 'blink
;;                        p90-auto-keyword-case nil
;;                        p90-leave-line-no nil
;;                        indent-tabs-mode nil
;;                        p90-font-lock-keywords p90-font-lock-keywords-2
;;                  )
;;       ;; These are not default.
;;       (abbrev-mode 1)             ; turn on abbreviation mode
;;       (p90-add-imenu-menu)        ; extra menu with functions etc.
;;       (if p90-auto-keyword-case   ; change case of all keywords on startup
;;           (p90-change-keywords p90-auto-keyword-case))
;;       ))
;;
;; in your .emacs file. You can also customize the lists
;; p90-font-lock-keywords, etc.
;;
;; The auto-fill and abbreviation minor modes are accessible from the P90 menu,
;; or by using M-x auto-fill-mode and M-x abbrev-mode, respectively.

;; Remarks
;; 1) Line numbers are by default left-justified. If p90-leave-line-no is
;;    non-nil, the line numbers are never touched.
;; 2) Multi-; statements like "do i=1,20 ; j=j+i ; end do" are not handled
;;    correctly, but I imagine them to be rare.
;; 3) Regexps for hilit19 are no longer supported.
;; 4) For FIXED FORMAT code, use fortran mode.
;; 5) This mode does not work under emacs-18.x.
;; 6) Preprocessor directives, i.e., lines starting with # are left-justified
;;    and are untouched by all case-changing commands. There is, at present, no
;;    mechanism for treating multi-line directives (continued by \ ).
;; 7) f77 do-loops do 10 i=.. ; ; 10 continue are not correctly indented.
;;    You are urged to use p90-do loops (with labels if you wish).
;; 8) The highlighting mode under XEmacs is not as complete as under Emacs.

;; List of user commands
;;   p90-previous-statement         p90-next-statement
;;   p90-beginning-of-subprogram    p90-end-of-subprogram   p90-mark-subprogram
;;   p90-comment-region
;;   p90-indent-line                p90-indent-new-line
;;   p90-indent-region    (can be called by calling indent-region)
;;   p90-indent-subprogram
;;   p90-break-line                 p90-join-lines
;;   p90-fill-region
;;   p90-insert-end
;;   p90-upcase-keywords            p90-upcase-region-keywords
;;   p90-downcase-keywords          p90-downcase-region-keywords
;;   p90-capitalize-keywords        p90-capitalize-region-keywords
;;   p90-add-imenu-menu
;;   p90-font-lock-1, p90-font-lock-2, p90-font-lock-3, p90-font-lock-4

;; Original author's thanks
;; Thanks to all the people who have tested the mode. Special thanks to Jens
;; Bloch Helmers for encouraging me to write this code, for creative
;; suggestions as well as for the lists of hpf-commands.
;; Also thanks to the authors of the fortran and pascal modes, on which some
;; of this code is built.

;;; Code:

;; TODO
;; 1. Any missing F2003 syntax?
;; 2. Have "p90-mode" just recognize P90 syntax, then derived modes
;; "f95-mode", "f2003-mode" for the language revisions.
;; 3. Support for align.
;; Font-locking:
;; 1. OpenMP, OpenMPI?, preprocessor highlighting.
;; 2. integer_name = 1
;; 3. Labels for "else" statements (F2003)?

(defvar comment-auto-fill-only-comments)
(defvar font-lock-keywords)

;; User options

(defgroup p90 nil
  "Major mode for editing free format Fortran 90,95 code."
  :link '(custom-group-link :tag "Font Lock Faces group" font-lock-faces)
  :group 'languages)

(defgroup p90-indent nil
  "Indentation in free format Fortran."
  :prefix "p90-"
  :group  'p90)


(defcustom p90-do-indent 3
  "Extra indentation applied to DO blocks."
  :type  'integer
  :safe  'integerp
  :group 'p90-indent)

(defcustom p90-if-indent 3
  "Extra indentation applied to IF, SELECT CASE, WHERE and FORALL blocks."
  :type  'integer
  :safe  'integerp
  :group 'p90-indent)

(defcustom p90-type-indent 3
  "Extra indentation applied to TYPE, ENUM, INTERFACE and BLOCK DATA blocks."
  :type  'integer
  :safe  'integerp
  :group 'p90-indent)

(defcustom p90-program-indent 2
  "Extra indentation applied to PROGRAM, MODULE, SUBROUTINE, FUNCTION blocks."
  :type  'integer
  :safe  'integerp
  :group 'p90-indent)

(defcustom p90-associate-indent 2
  "Extra indentation applied to ASSOCIATE blocks."
  :type  'integer
  :safe  'integerp
  :group 'p90-indent
  :version "23.1")

(defcustom p90-continuation-indent 5
  "Extra indentation applied to continuation lines."
  :type  'integer
  :safe  'integerp
  :group 'p90-indent)

(defcustom p90-comment-region "!!$"
  "String inserted by \\[p90-comment-region] at start of each line in region."
  :type  'string
  :safe  'stringp
  :group 'p90-indent)

(defcustom p90-indented-comment-re "!"
  "Regexp matching comments to indent as code."
  :type  'regexp
  :safe  'stringp
  :group 'p90-indent)

(defcustom p90-directive-comment-re "!hpf\\$"
  "Regexp of comment-like directive like \"!HPF\\\\$\", not to be indented."
  :type  'regexp
  :safe  'stringp
  :group 'p90-indent)

(defcustom p90-beginning-ampersand t
  "Non-nil gives automatic insertion of \& at start of continuation line."
  :type  'boolean
  :safe  'booleanp
  :group 'p90)

(defcustom p90-smart-end 'blink
  "Qualification of END statements according to the matching block start.
For example, the END that closes an IF block is changed to END
IF.  If the block has a label, this is added as well.  Allowed
values are 'blink, 'no-blink, and nil.  If nil, nothing is done.
The other two settings have the same effect, but 'blink
additionally blinks the cursor to the start of the block."
  :type  '(choice (const blink) (const no-blink) (const nil))
  :safe  (lambda (value) (memq value '(blink no-blink nil)))
  :group 'p90)

(defcustom p90-break-delimiters "[-+\\*/><=,% \t]"
  "Regexp matching delimiter characters at which lines may be broken.
There are some common two-character tokens where one or more of
the members matches this regexp.  Although Fortran allows breaks
within lexical tokens (provided the next line has a beginning ampersand),
the constant `p90-no-break-re' ensures that such tokens are not split."
  :type 'regexp
  :safe 'stringp
  :group 'p90)

(defcustom p90-break-before-delimiters t
  "Non-nil causes `p90-do-auto-fill' to break lines before delimiters."
  :type 'boolean
  :safe 'booleanp
  :group 'p90)

(defcustom p90-auto-keyword-case nil
  "Automatic case conversion of keywords.
The options are 'downcase-word, 'upcase-word, 'capitalize-word and nil."
  :type  '(choice (const downcase-word) (const upcase-word)
                  (const capitalize-word) (const nil))
  :safe (lambda (value) (memq value '(downcase-word
                                      capitalize-word upcase-word nil)))
  :group 'p90)

(defcustom p90-leave-line-no nil
  "If non-nil, line numbers are not left justified."
  :type  'boolean
  :safe  'booleanp
  :group 'p90)

(defcustom p90-mode-hook nil
  "Hook run when entering P90 mode."
  :type    'hook
  ;; Not the only safe options, but some common ones.
  :safe    (lambda (value) (member value '((p90-add-imenu-menu) nil)))
  :options '(p90-add-imenu-menu)
  :group   'p90)

;; User options end here.

(defconst p90-keywords-re
  (regexp-opt '("allocatable" "allocate" "assign" "assignment" "backspace"
                "block" "call" "case" "character" "close" "common" "complex"
                "contains" "continue" "cycle" "data" "deallocate"
                "dimension" "do" "double" "else" "elseif" "elsewhere" "end"
                "enddo" "endfile" "endif" "entry" "equivalence" "exit"
                "external" "forall" "format" "function" "goto" "if"
                "implicit" "include" "inquire" "integer" "intent"
                "interface" "intrinsic" "logical" "module" "namelist" "none"
                "nullify" "only" "open" "operator" "optional" "parameter"
                "pause" "pointer" "precision" "print" "private" "procedure"
                "program" "public" "read" "real" "recursive" "result" "return"
                "rewind" "save" "select" "sequence" "stop" "subroutine"
                "target" "then" "type" "use" "where" "while" "write"
                ;; F95 keywords.
                "elemental" "pure"
                ;; F2003
                "abstract" "associate" "asynchronous" "bind" "class"
                "deferred" "enum" "enumerator" "extends" "extends_type_of"
                "final" "generic" "import" "non_intrinsic" "non_overridable"
                "nopass" "pass" "protected" "same_type_as" "value" "volatile"
                ) 'words)
  "Regexp used by the function `p90-change-keywords'.")

(defconst p90-keywords-level-3-re
  (regexp-opt
   '("allocatable" "allocate" "assign" "assignment" "backspace"
     "close" "deallocate" "dimension" "endfile" "entry" "equivalence"
     "external" "inquire" "intent" "intrinsic" "nullify" "only" "open"
     ;; FIXME operator and assignment should be F2003 procedures?
     "operator" "optional" "parameter" "pause" "pointer" "print" "private"
     "public" "read" "recursive" "result" "rewind" "save" "select"
     "sequence" "target" "write"
     ;; F95 keywords.
     "elemental" "pure"
     ;; F2003. asynchronous separate.
     "abstract" "deferred" "import" "final" "non_intrinsic" "non_overridable"
     "nopass" "pass" "protected" "value" "volatile"
     ) 'words)
  "Keyword-regexp for font-lock level >= 3.")

(defconst p90-procedures-re
  (concat "\\<"
          (regexp-opt
           '("abs" "achar" "acos" "adjustl" "adjustr" "aimag" "aint"
             "all" "allocated" "anint" "any" "asin" "associated"
             "atan" "atan2" "bit_size" "btest" "ceiling" "char" "cmplx"
             "conjg" "cos" "cosh" "count" "cshift" "date_and_time" "dble"
             "digits" "dim" "dot_product" "dprod" "eoshift" "epsilon"
             "exp" "exponent" "floor" "fraction" "huge" "iachar" "iand"
             "ibclr" "ibits" "ibset" "ichar" "ieor" "index" "int" "ior"
             "ishft" "ishftc" "kind" "lbound" "len" "len_trim" "lge" "lgt"
             "lle" "llt" "log" "log10" "logical" "matmul" "max"
             "maxexponent" "maxloc" "maxval" "merge" "min" "minexponent"
             "minloc" "minval" "mod" "modulo" "mvbits" "nearest" "nint"
             "not" "pack" "precision" "present" "product" "radix"
             ;; Real is taken out here to avoid highlighting declarations.
             "random_number" "random_seed" "range" ;; "real"
             "repeat" "reshape" "rrspacing" "scale" "scan"
             "selected_int_kind" "selected_real_kind" "set_exponent"
             "shape" "sign" "sin" "sinh" "size" "spacing" "spread" "sqrt"
             "sum" "system_clock" "tan" "tanh" "tiny" "transfer"
             "transpose" "trim" "ubound" "unpack" "verify"
             ;; F95 intrinsic functions.
             "null" "cpu_time"
             ;; F2003.
             "move_alloc" "command_argument_count" "get_command"
             "get_command_argument" "get_environment_variable"
             "selected_char_kind" "wait" "flush" "new_line"
             "extends" "extends_type_of" "same_type_as" "bind"
             ;; F2003 ieee_arithmetic intrinsic module.
             "ieee_support_underflow_control" "ieee_get_underflow_mode"
             "ieee_set_underflow_mode"
             ;; F2003 iso_c_binding intrinsic module.
             "c_loc" "c_funloc" "c_associated" "c_f_pointer"
             "c_f_procpointer"
             ) t)
          ;; A left parenthesis to avoid highlighting non-procedures.
          "[ \t]*(")
  "Regexp whose first part matches P90 intrinsic procedures.")

(defconst p90-operators-re
  (concat "\\."
          (regexp-opt '("and" "eq" "eqv" "false" "ge" "gt" "le" "lt" "ne"
                        "neqv" "not" "or" "true") t)
          "\\.")
  "Regexp matching intrinsic operators.")

(defconst p90-hpf-keywords-re
  (regexp-opt
   ;; Intrinsic procedures.
   '("all_prefix" "all_scatter" "all_suffix" "any_prefix"
     "any_scatter" "any_suffix" "copy_prefix" "copy_scatter"
     "copy_suffix" "count_prefix" "count_scatter" "count_suffix"
     "grade_down" "grade_up"
     "hpf_alignment" "hpf_distribution" "hpf_template" "iall" "iall_prefix"
     "iall_scatter" "iall_suffix" "iany" "iany_prefix" "iany_scatter"
     "iany_suffix" "ilen" "iparity" "iparity_prefix"
     "iparity_scatter" "iparity_suffix" "leadz" "maxval_prefix"
     "maxval_scatter" "maxval_suffix" "minval_prefix" "minval_scatter"
     "minval_suffix" "number_of_processors" "parity"
     "parity_prefix" "parity_scatter" "parity_suffix" "popcnt" "poppar"
     "processors_shape" "product_prefix" "product_scatter"
     "product_suffix" "sum_prefix" "sum_scatter" "sum_suffix"
     ;; Directives.
     "align" "distribute" "dynamic" "independent" "inherit" "processors"
     "realign" "redistribute" "template"
     ;; Keywords.
     "block" "cyclic" "extrinsic" "new" "onto" "pure" "with") 'words)
  "Regexp for all HPF keywords, procedures and directives.")

(defconst p90-constants-re
  (regexp-opt '( ;; F2003 iso_fortran_env constants.
                "iso_fortran_env"
                "input_unit" "output_unit" "error_unit"
                "iostat_end" "iostat_eor"
                "numeric_storage_size" "character_storage_size"
                "file_storage_size"
                ;; F2003 iso_c_binding constants.
                "iso_c_binding"
                "c_int" "c_short" "c_long" "c_long_long" "c_signed_char"
                "c_size_t"
                "c_int8_t" "c_int16_t" "c_int32_t" "c_int64_t"
                "c_int_least8_t" "c_int_least16_t" "c_int_least32_t"
                "c_int_least64_t"
                "c_int_fast8_t" "c_int_fast16_t" "c_int_fast32_t"
                "c_int_fast64_t"
                "c_intmax_t" "c_intptr_t"
                "c_float" "c_double" "c_long_double"
                "c_float_complex" "c_double_complex" "c_long_double_complex"
                "c_bool" "c_char"
                "c_null_char" "c_alert" "c_backspace" "c_form_feed"
                "c_new_line" "c_carriage_return" "c_horizontal_tab"
                "c_vertical_tab"
                "c_ptr" "c_funptr" "c_null_ptr" "c_null_funptr"
                "ieee_exceptions"
                "ieee_arithmetic"
                "ieee_features"
                ) 'words)
  "Regexp for Fortran intrinsic constants.")

;; cf p90-looking-at-type-like.
(defun p90-typedef-matcher (limit)
  "Search for the start/end of the definition of a derived type, up to LIMIT.
Set the match data so that subexpression 1,2 are the TYPE, and
type-name parts, respectively."
  (let (found l)
    (while (and (re-search-forward "\\<\\(\\(?:end[ \t]*\\)?type\\)\\>[ \t]*"
                                   limit t)
                (not (setq found
                           (progn
                             (setq l (match-data))
                             (unless (looking-at "\\(is\\>\\|(\\)")
                               (when (if (looking-at "\\(\\sw+\\)")
                                         (goto-char (match-end 0))
                                       (re-search-forward
                                        "[ \t]*::[ \t]*\\(\\sw+\\)"
                                        (line-end-position) t))
                                 ;; 0 is wrong, but we don't use it.
                                 (set-match-data
                                  (append l (list (match-beginning 1)
                                                  (match-end 1))))
                                 t)))))))
    found))

(defvar p90-font-lock-keywords-1
  (list
   ;; Special highlighting of "module procedure".
   '("\\<\\(module[ \t]*procedure\\)\\>\\([^()\n]*::\\)?[ \t]*\\([^&!\n]*\\)"
     (1 font-lock-keyword-face) (3 font-lock-function-name-face nil t))
   ;; Highlight definition of derived type.
;;;    '("\\<\\(\\(?:end[ \t]*\\)?type\\)\\>\\([^()\n]*::\\)?[ \t]*\\(\\sw+\\)"
;;;      (1 font-lock-keyword-face) (3 font-lock-function-name-face))
   '(p90-typedef-matcher
     (1 font-lock-keyword-face) (2 font-lock-function-name-face))
    ;; F2003.  Prevent operators being highlighted as functions.
    '("\\<\\(\\(?:end[ \t]*\\)?interface[ \t]*\\(?:assignment\\|operator\\|\
read\\|write\\)\\)[ \t]*(" (1 font-lock-keyword-face t))
   ;; Other functions and declarations.  Named interfaces = F2003.
   '("\\<\\(\\(?:end[ \t]*\\)?\\(program\\|module\\|function\\|associate\\|\
subroutine\\|interface\\)\\|use\\|call\\)\\>[ \t]*\\(\\sw+\\)?"
     (1 font-lock-keyword-face) (3 font-lock-function-name-face nil t))
   ;; F2003.
   '("\\<\\(use\\)[ \t]*,[ \t]*\\(\\(?:non_\\)?intrinsic\\)[ \t]*::[ \t]*\
\\(\\sw+\\)"
     (1 font-lock-keyword-face) (2 font-lock-keyword-face)
     (3 font-lock-function-name-face))
   "\\<\\(\\(end[ \t]*\\)?block[ \t]*data\\|contains\\)\\>"
   ;; "abstract interface" is F2003.
   '("\\<abstract[ \t]*interface\\>" (0 font-lock-keyword-face t)))
  "This does fairly subdued highlighting of comments and function calls.")

;; NB not explicitly handling this, yet it seems to work.
;; type(...) function foo()
(defun p90-typedec-matcher (limit)
  "Search for the declaration of variables of derived type, up to LIMIT.
Set the match data so that subexpression 1,2 are the TYPE(...),
and variable-name parts, respectively."
  ;; Matcher functions must return nil only when there are no more
  ;; matches within the search range.
  (let (found l)
    (while (and (re-search-forward "\\<\\(type\\|class\\)[ \t]*(" limit t)
                (not
                 (setq found
                       (condition-case nil
                           (progn
                             ;; Set l after this to just highlight
                             ;; the "type" part.
                             (backward-char 1)
                             ;; Needed for: type( foo(...) ) :: bar
                             (forward-sexp)
                             (setq l (list (match-beginning 0) (point)))
                             (skip-chars-forward " \t")
                             (when
                                 (re-search-forward
                                  ;; type (foo) bar, qux
                                  (if (looking-at "\\sw+")
                                      "\\([^&!\n]+\\)"
                                    ;; type (foo), stuff :: bar, qux
                                    "::[ \t]*\\([^&!\n]+\\)")
                                  (line-end-position) t)
                               (set-match-data
                                (append (list (car l) (match-end 1))
                                        l (list (match-beginning 1)
                                                (match-end 1))))
                               t))
                         (error nil))))))
    found))

(defvar p90-font-lock-keywords-2
  (append
   p90-font-lock-keywords-1
   (list
    ;; Variable declarations (avoid the real function call).
    ;; NB by accident (?), this correctly fontifies the "integer" in:
    ;; integer () function foo ()
    ;; because "() function foo ()" matches \\3.
    ;; The "pure" part does not really belong here, but was added to
    ;; exploit that hack.
    ;; The "function foo" bit is correctly fontified by keywords-1.
    ;; TODO ? actually check for balanced parens in that case.
    '("^[ \t0-9]*\\(?:pure\\|elemental\\)?[ \t]*\
\\(real\\|integer\\|c\\(haracter\\|omplex\\)\\|\
enumerator\\|generic\\|procedure\\|logical\\|double[ \t]*precision\\)\
\\(.*::\\|[ \t]*(.*)\\)?\\([^&!\n]*\\)"
      (1 font-lock-type-face t) (4 font-lock-variable-name-face t))
    ;; Derived type/class variables.
    ;; TODO ? If we just highlighted the "type" part, rather than
    ;; "type(...)", this could be in the previous expression. And this
    ;; would be consistent with integer( kind=8 ), etc.
    '(p90-typedec-matcher
      (1 font-lock-type-face) (2 font-lock-variable-name-face))
    ;; "real function foo (args)". Must override previous.  Note hack
    ;; to get "args" unhighlighted again. Might not always be right,
    ;; but probably better than leaving them as variables.
    ;; NB not explicitly handling this case:
    ;; integer( kind=1 ) function foo()
    ;; thanks to the happy accident described above.
    ;; Not anchored, so don't need to worry about "pure" etc.
    '("\\<\\(\\(real\\|integer\\|c\\(haracter\\|omplex\\)\\|\
logical\\|double[ \t]*precision\\|\
\\(?:type\\|class\\)[ \t]*([ \t]*\\sw+[ \t]*)\\)[ \t]*\\)\
\\(function\\)\\>[ \t]*\\(\\sw+\\)[ \t]*\\(([^&!\n]*)\\)"
      (1 font-lock-type-face t) (4 font-lock-keyword-face t)
      (5 font-lock-function-name-face t) (6 'default t))
    ;; enum (F2003; must be followed by ", bind(C)").
    '("\\<\\(enum\\)[ \t]*," (1 font-lock-keyword-face))
    ;; end do, enum (F2003), if, select, where, and forall constructs.
    '("\\<\\(end[ \t]*\\(do\\|if\\|enum\\|select\\|forall\\|where\\)\\)\\>\
\\([ \t]+\\(\\sw+\\)\\)?"
      (1 font-lock-keyword-face) (3 font-lock-constant-face nil t))
    '("^[ \t0-9]*\\(\\(\\sw+\\)[ \t]*:[ \t]*\\)?\\(\\(if\\|\
do\\([ \t]*while\\)?\\|select[ \t]*\\(?:case\\|type\\)\\|where\\|\
forall\\)\\)\\>"
      (2 font-lock-constant-face nil t) (3 font-lock-keyword-face))
    ;; Implicit declaration.
    '("\\<\\(implicit\\)[ \t]*\\(real\\|integer\\|c\\(haracter\\|omplex\\)\
\\|enumerator\\|procedure\\|\
logical\\|double[ \t]*precision\\|type[ \t]*(\\sw+)\\|none\\)[ \t]*"
      (1 font-lock-keyword-face) (2 font-lock-type-face))
    '("\\<\\(namelist\\|common\\)[ \t]*\/\\(\\sw+\\)?\/"
      (1 font-lock-keyword-face) (2 font-lock-constant-face nil t))
    "\\<else\\([ \t]*if\\|where\\)?\\>"
    '("\\(&\\)[ \t]*\\(!\\|$\\)"  (1 font-lock-keyword-face))
    "\\<\\(then\\|continue\\|format\\|include\\|stop\\|return\\)\\>"
    '("\\<\\(exit\\|cycle\\)[ \t]*\\(\\sw+\\)?\\>"
      (1 font-lock-keyword-face) (2 font-lock-constant-face nil t))
    '("\\<\\(case\\)[ \t]*\\(default\\|(\\)" . 1)
    ;; F2003 "class default".
    '("\\<\\(class\\)[ \t]*default" . 1)
    ;; F2003 "type is" in a "select type" block.
    '("\\<\\(\\(type\\|class\\)[ \t]*is\\)[ \t]*(" (1 font-lock-keyword-face t))
    '("\\<\\(do\\|go[ \t]*to\\)\\>[ \t]*\\([0-9]+\\)"
      (1 font-lock-keyword-face) (2 font-lock-constant-face))
    ;; Line numbers (lines whose first character after number is letter).
    '("^[ \t]*\\([0-9]+\\)[ \t]*[a-z]+" (1 font-lock-constant-face t))))
  "Highlights declarations, do-loops and other constructs.")

(defvar p90-font-lock-keywords-3
  (append p90-font-lock-keywords-2
          (list
           p90-keywords-level-3-re
           p90-operators-re
           ;; FIXME why isn't this font-lock-builtin-face, which
           ;; otherwise we hardly use, as in fortran.el?
           (list p90-procedures-re '(1 font-lock-keyword-face keep))
           "\\<real\\>"                 ; avoid overwriting real defs
           ;; As an attribute, but not as an optional argument.
           '("\\<\\(asynchronous\\)[ \t]*[^=]" . 1)))
  "Highlights all P90 keywords and intrinsic procedures.")

(defvar p90-font-lock-keywords-4
  (append p90-font-lock-keywords-3
          (list (cons p90-constants-re 'font-lock-constant-face)
                p90-hpf-keywords-re))
  "Highlights all P90 and HPF keywords and constants.")

(defvar p90-font-lock-keywords
  p90-font-lock-keywords-2
  "*Default expressions to highlight in P90 mode.
Can be overridden by the value of `font-lock-maximum-decoration'.")


(defvar p90-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\! "<"  table) ; begin comment
    (modify-syntax-entry ?\n ">"  table) ; end comment
    ;; FIXME: This goes against the convention: it should be "_".
    (modify-syntax-entry ?@  "w"  table) ; at sign in names
    (modify-syntax-entry ?_  "w"  table) ; underscore in names
    (modify-syntax-entry ?\' "\"" table) ; string quote
    (modify-syntax-entry ?\" "\"" table) ; string quote
    ;; FIXME: We used to set ` to word syntax for the benefit of abbrevs, but
    ;; we do not need it any more.  Not sure if it should be "_" or "." now.
    (modify-syntax-entry ?\` "_"  table)
    (modify-syntax-entry ?\r " "  table) ; return is whitespace
    (modify-syntax-entry ?+  "."  table) ; punctuation
    (modify-syntax-entry ?-  "."  table)
    (modify-syntax-entry ?=  "."  table)
    (modify-syntax-entry ?*  "."  table)
    (modify-syntax-entry ?/  "."  table)
    ;; I think that the f95 standard leaves the behavior of \
    ;; unspecified, but that f2k will require it to be non-special.
    ;; Use `p90-backslash-not-special' to change.
    (modify-syntax-entry ?\\ "\\" table) ; escape chars
    table)
  "Syntax table used in P90 mode.")

(defvar p90-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "`"        'p90-abbrev-start)
    (define-key map "\C-c;"    'p90-comment-region)
    (define-key map "\C-\M-a"  'p90-beginning-of-subprogram)
    (define-key map "\C-\M-e"  'p90-end-of-subprogram)
    (define-key map "\C-\M-h"  'p90-mark-subprogram)
    (define-key map "\C-\M-n"  'p90-end-of-block)
    (define-key map "\C-\M-p"  'p90-beginning-of-block)
    (define-key map "\C-\M-q"  'p90-indent-subprogram)
    (define-key map "\C-j"     'p90-indent-new-line) ; LFD equals C-j
;;;    (define-key map "\r"       'newline)
    (define-key map "\C-c\r"   'p90-break-line)
;;;  (define-key map [M-return] 'p90-break-line)
    (define-key map "\C-c\C-a" 'p90-previous-block)
    (define-key map "\C-c\C-e" 'p90-next-block)
    (define-key map "\C-c\C-d" 'p90-join-lines)
    (define-key map "\C-c\C-f" 'p90-fill-region)
    (define-key map "\C-c\C-p" 'p90-previous-statement)
    (define-key map "\C-c\C-n" 'p90-next-statement)
    (define-key map "\C-c\C-w" 'p90-insert-end)
    ;; Standard tab binding will call this, and also handle regions.
;;;    (define-key map "\t"       'p90-indent-line)
    (define-key map ","        'p90-electric-insert)
    (define-key map "+"        'p90-electric-insert)
    (define-key map "-"        'p90-electric-insert)
    (define-key map "*"        'p90-electric-insert)
    (define-key map "/"        'p90-electric-insert)

    (easy-menu-define p90-menu map "Menu for P90 mode."
      `("P90"
        ("Customization"
         ,(custom-menu-create 'p90)
         ;; FIXME useless?
         ["Set"  Custom-set :active t
          :help "Set current value of all edited settings in the buffer"]
         ["Save" Custom-save :active t
          :help "Set and save all edited settings"]
         ["Reset to Current" Custom-reset-current :active t
          :help "Reset all edited settings to current"]
         ["Reset to Saved" Custom-reset-saved :active t
          :help "Reset all edited or set settings to saved"]
         ["Reset to Standard Settings" Custom-reset-standard :active t
          :help "Erase all cusomizations in buffer"]
         )
        "--"
        ["Indent Subprogram" p90-indent-subprogram t]
        ["Mark Subprogram" p90-mark-subprogram :active t :help
         "Mark the end of the current subprogram, move point to the start"]
        ["Beginning of Subprogram" p90-beginning-of-subprogram :active t
         :help "Move point to the start of the current subprogram"]
        ["End of Subprogram" p90-end-of-subprogram :active t
         :help "Move point to the end of the current subprogram"]
        "--"
        ["(Un)Comment Region" p90-comment-region :active mark-active
         :help "Comment or uncomment the region"]
        ["Indent Region" p90-indent-region :active mark-active]
        ["Fill Region" p90-fill-region :active mark-active
         :help "Fill long lines in the region"]
        "--"
        ["Break Line at Point" p90-break-line :active t
         :help "Break the current line at point"]
        ["Join with Previous Line" p90-join-lines :active t
         :help "Join the current line to the previous one"]
        ["Insert Block End" p90-insert-end :active t
         :help "Insert an end statement for the current code block"]
        "--"
        ("Highlighting"
         :help "Fontify this buffer to varying degrees"
         ["Toggle font-lock-mode" font-lock-mode :selected font-lock-mode
          :style toggle :help "Fontify text in this buffer"]
         "--"
         ["Light highlighting (level 1)"    p90-font-lock-1 t]
         ["Moderate highlighting (level 2)" p90-font-lock-2 t]
         ["Heavy highlighting (level 3)"    p90-font-lock-3 t]
         ["Maximum highlighting (level 4)"  p90-font-lock-4 t]
         )
        ("Change Keyword Case"
         :help "Change the case of keywords in the buffer or region"
         ["Upcase Keywords (buffer)"     p90-upcase-keywords     t]
         ["Capitalize Keywords (buffer)" p90-capitalize-keywords t]
         ["Downcase Keywords (buffer)"   p90-downcase-keywords   t]
         "--"
         ["Upcase Keywords (region)"     p90-upcase-region-keywords
          mark-active]
         ["Capitalize Keywords (region)" p90-capitalize-region-keywords
          mark-active]
         ["Downcase Keywords (region)"   p90-downcase-region-keywords
          mark-active]
         )
        "--"
        ["Toggle Auto Fill" auto-fill-mode :selected auto-fill-function
         :style toggle
         :help "Automatically fill text while typing in this buffer"]
        ["Toggle Abbrev Mode" abbrev-mode :selected abbrev-mode
         :style toggle :help "Expand abbreviations while typing in this buffer"]
        ["Add Imenu Menu" p90-add-imenu-menu
         :active   (not (lookup-key (current-local-map) [menu-bar index]))
         :included (fboundp 'imenu-add-to-menubar)
         :help "Add an index menu to the menu-bar"
         ]))
    map)
  "Keymap used in P90 mode.")


(defun p90-font-lock-n (n)
  "Set `font-lock-keywords' to P90 level N keywords."
  (font-lock-mode 1)
  (setq font-lock-keywords
        (symbol-value (intern-soft (format "p90-font-lock-keywords-%d" n))))
  (font-lock-fontify-buffer))

(defun p90-font-lock-1 ()
  "Set `font-lock-keywords' to `p90-font-lock-keywords-1'."
  (interactive)
  (p90-font-lock-n 1))

(defun p90-font-lock-2 ()
  "Set `font-lock-keywords' to `p90-font-lock-keywords-2'."
  (interactive)
  (p90-font-lock-n 2))

(defun p90-font-lock-3 ()
  "Set `font-lock-keywords' to `p90-font-lock-keywords-3'."
  (interactive)
  (p90-font-lock-n 3))

(defun p90-font-lock-4 ()
  "Set `font-lock-keywords' to `p90-font-lock-keywords-4'."
  (interactive)
  (p90-font-lock-n 4))

;; Regexps for finding program structures.
(defconst p90-blocks-re
  (concat "\\(block[ \t]*data\\|"
          (regexp-opt '("do" "if" "interface" "function" "module" "program"
                        "select" "subroutine" "type" "where" "forall"
                        ;; F2003.
                        "enum" "associate"))
          "\\)\\>")
  "Regexp potentially indicating a \"block\" of P90 code.")

(defconst p90-program-block-re
  (regexp-opt '("program" "module" "subroutine" "function") 'paren)
  "Regexp used to locate the start/end of a \"subprogram\".")

;; "class is" is F2003.
(defconst p90-else-like-re
  "\\(else\\([ \t]*if\\|where\\)?\\|case[ \t]*\\(default\\|(\\)\\|\
\\(class\\|type\\)[ \t]*is[ \t]*(\\|class[ \t]*default\\)"
  "Regexp matching an ELSE IF, ELSEWHERE, CASE, CLASS/TYPE IS statement.")

(defconst p90-end-if-re
  (concat "end[ \t]*"
          (regexp-opt '("if" "select" "where" "forall") 'paren)
          "\\>")
  "Regexp matching the end of an IF, SELECT, WHERE, FORALL block.")

(defconst p90-end-type-re
  "end[ \t]*\\(type\\|enum\\|interface\\|block[ \t]*data\\)\\>"
  "Regexp matching the end of a TYPE, ENUM, INTERFACE, BLOCK DATA section.")

(defconst p90-end-associate-re
  "end[ \t]*associate\\>"
  "Regexp matching the end of an ASSOCIATE block.")

;; This is for a TYPE block, not a variable of derived TYPE.
;; Hence no need to add CLASS for F2003.
(defconst p90-type-def-re
  ;; type word
  ;; type :: word
  ;; type, stuff :: word
  ;; NOT "type ("
  "\\<\\(type\\)\\>\\(?:[^()\n]*::\\)?[ \t]*\\(\\sw+\\)"
  "Regexp matching the definition of a derived type.")

(defconst p90-typeis-re
  "\\<\\(class\\|type\\)[ \t]*is[ \t]*("
  "Regexp matching a CLASS/TYPE IS statement.")

(defconst p90-no-break-re
  (regexp-opt '("**" "//" "=>" ">=" "<=" "==" "/=" "(/" "/)") 'paren)
  "Regexp specifying two-character tokens not to split when breaking lines.
Each token has one or more of the characters from `p90-break-delimiters'.
Note that if only one of the characters is from that variable,
then the presence of the token here allows a line-break before or
after the other character, where a break would not normally be
allowed.  This minor issue currently only affects \"(/\" and \"/)\".")

(defvar p90-cache-position nil
  "Temporary position used to speed up region operations.")
(make-variable-buffer-local 'p90-cache-position)


;; Hideshow support.
(defconst p90-end-block-re
  (concat "^[ \t0-9]*\\<end[ \t]*"
          (regexp-opt '("do" "if" "forall" "function" "interface"
                        "module" "program" "select" "subroutine"
                        "type" "where" "enum" "associate") t)
          "\\>")
  "Regexp matching the end of an P90 \"block\", from the line start.
Used in the P90 entry in `hs-special-modes-alist'.")

;; Ignore the fact that FUNCTION, SUBROUTINE, WHERE, FORALL have a
;; following "(".  DO, CASE, IF can have labels.
(defconst p90-start-block-re
  (concat
   "^[ \t0-9]*"                         ; statement number
   "\\(\\("
   "\\(\\sw+[ \t]*:[ \t]*\\)?"          ; structure label
   "\\(do\\|select[ \t]*\\(case\\|type\\)\\|"
   ;; See comments in fortran-start-block-re for the problems of IF.
   "if[ \t]*(\\(.*\\|"
   ".*\n\\([^if]*\\([^i].\\|.[^f]\\|.\\>\\)\\)\\)\\<then\\|"
   ;; Distinguish WHERE block from isolated WHERE.
   "\\(where\\|forall\\)[ \t]*(.*)[ \t]*\\(!\\|$\\)\\)\\)"
   "\\|"
   ;; Avoid F2003 "type is" in "select type",
   ;; and also variables of derived type "type (foo)".
   ;; "type, foo" must be a block (?).
   "type[ \t,]\\("
   "[^i(!\n\"\& \t]\\|"                 ; not-i(
   "i[^s!\n\"\& \t]\\|"                 ; i not-s
   "is\\sw\\)\\|"
   ;; "abstract interface" is F2003.
   "program\\|\\(?:abstract[ \t]*\\)?interface\\|module\\|"
   ;; "enum", but not "enumerator".
   "function\\|subroutine\\|enum[^e]\\|associate"
   "\\)"
   "[ \t]*")
  "Regexp matching the start of an P90 \"block\", from the line start.
A simple regexp cannot do this in fully correct fashion, so this
tries to strike a compromise between complexity and flexibility.
Used in the P90 entry in `hs-special-modes-alist'.")

;; hs-special-modes-alist is autoloaded.
(add-to-list 'hs-special-modes-alist
             `(p90-mode ,p90-start-block-re ,p90-end-block-re
                        "!" p90-end-of-block nil))


;; Imenu support.
;; FIXME trivial to extend this to enum. Worth it?
(defun p90-imenu-type-matcher ()
  "Search backward for the start of a derived type.
Set subexpression 1 in the match-data to the name of the type."
  (let (found)
    (while (and (re-search-backward "^[ \t0-9]*type[ \t]*" nil t)
                (not (setq found
                           (save-excursion
                             (goto-char (match-end 0))
                             (unless (looking-at "\\(is\\>\\|(\\)")
                               (or (looking-at "\\(\\sw+\\)")
                                   (re-search-forward
                                    "[ \t]*::[ \t]*\\(\\sw+\\)"
                                    (line-end-position) t))))))))
    found))

(defvar p90-imenu-generic-expression
  (let ((good-char "[^!\"\&\n \t]") (not-e "[^e!\n\"\& \t]")
        (not-n "[^n!\n\"\& \t]") (not-d "[^d!\n\"\& \t]")
        ;; (not-ib "[^i(!\n\"\& \t]") (not-s "[^s!\n\"\& \t]")
        )
    (list
     '(nil "^[ \t0-9]*program[ \t]+\\(\\sw+\\)" 1)
     '("Modules" "^[ \t0-9]*module[ \t]+\\(\\sw+\\)[ \t]*\\(!\\|$\\)" 1)
     (list "Types" 'p90-imenu-type-matcher 1)
     ;; Does not handle: "type[, stuff] :: foo".
;;;      (format "^[ \t0-9]*type[ \t]+\\(\\(%s\\|i%s\\|is\\sw\\)\\sw*\\)"
;;;              not-ib not-s)
;;;      1)
     ;; Can't get the subexpression numbers to match in the two branches.
;;;      (format "^[ \t0-9]*type\\([ \t]*,.*\\(::\\)[ \t]*\\(\\sw+\\)\\|[ \t]+\\(\\(%s\\|i%s\\|is\\sw\\)\\sw*\\)\\)" not-ib not-s)
;;;      3)
     (list
      "Procedures"
      (concat
       "^[ \t0-9]*"
       "\\("
       ;; At least three non-space characters before function/subroutine.
       ;; Check that the last three non-space characters do not spell E N D.
       "[^!\"\&\n]*\\("
       not-e good-char good-char "\\|"
       good-char not-n good-char "\\|"
       good-char good-char not-d "\\)"
       "\\|"
       ;; Less than three non-space characters before function/subroutine.
       good-char "?" good-char "?"
       "\\)"
       "[ \t]*\\(function\\|subroutine\\)[ \t]+\\(\\sw+\\)")
      4)))
  "Value for `imenu-generic-expression' in P90 mode.")

(defun p90-add-imenu-menu ()
  "Add an imenu menu to the menubar."
  (interactive)
  (if (lookup-key (current-local-map) [menu-bar index])
      (message "%s" "P90-imenu already exists.")
    (imenu-add-to-menubar "P90-imenu")
    (redraw-frame (selected-frame))))


;; Abbrevs have generally two letters, except standard types `c, `i, `r, `t.
(define-abbrev-table 'p90-mode-abbrev-table
  (mapcar (lambda (e) (list (car e) (cdr e) nil :system t))
          '(("`al"  . "allocate"     )
            ("`ab"  . "allocatable"  )
            ("`ai"  . "abstract interface")
            ("`as"  . "assignment"   )
            ("`asy" . "asynchronous" )
            ("`ba"  . "backspace"    )
            ("`bd"  . "block data"   )
            ("`c"   . "character"    )
            ("`cl"  . "close"        )
            ("`cm"  . "common"       )
            ("`cx"  . "complex"      )
            ("`cn"  . "contains"     )
            ("`cy"  . "cycle"        )
            ("`de"  . "deallocate"   )
            ("`df"  . "define"       )
            ("`di"  . "dimension"    )
            ("`dp"  . "double precision")
            ("`dw"  . "do while"     )
            ("`el"  . "else"         )
            ("`eli" . "else if"      )
            ("`elw" . "elsewhere"    )
            ("`em"  . "elemental"    )
            ("`e"   . "enumerator"   )
            ("`eq"  . "equivalence"  )
            ("`ex"  . "external"     )
            ("`ey"  . "entry"        )
            ("`fl"  . "forall"       )
            ("`fo"  . "format"       )
            ("`fu"  . "function"     )
            ("`fa"  . ".false."      )
            ("`im"  . "implicit none")
            ("`in"  . "include"      )
            ("`i"   . "integer"      )
            ("`it"  . "intent"       )
            ("`if"  . "interface"    )
            ("`lo"  . "logical"      )
            ("`mo"  . "module"       )
            ("`na"  . "namelist"     )
            ("`nu"  . "nullify"      )
            ("`op"  . "optional"     )
            ("`pa"  . "parameter"    )
            ("`po"  . "pointer"      )
            ("`pr"  . "print"        )
            ("`pi"  . "private"      )
            ("`pm"  . "program"      )
            ("`pr"  . "protected"    )
            ("`pu"  . "public"       )
            ("`r"   . "real"         )
            ("`rc"  . "recursive"    )
            ("`rt"  . "return"       )
            ("`rw"  . "rewind"       )
            ("`se"  . "select"       )
            ("`sq"  . "sequence"     )
            ("`su"  . "subroutine"   )
            ("`ta"  . "target"       )
            ("`tr"  . ".true."       )
            ("`t"   . "type"         )
            ("`vo"  . "volatile"     )
            ("`wh"  . "where"        )
            ("`wr"  . "write"        )))
  "Abbrev table for P90 mode."
  ;; Accept ` as the first char of an abbrev.  Also allow _ in abbrevs.
  :regexp "\\(?:[^[:word:]_`]\\|^\\)\\(`?[[:word:]_]+\\)[^[:word:]_]*")

;;;###autoload
(defun p90-mode ()
  "Major mode for editing Fortran 90,95 code in free format.
For fixed format code, use `fortran-mode'.

\\[p90-indent-line] indents the current line.
\\[p90-indent-new-line] indents current line and creates a new\
 indented line.
\\[p90-indent-subprogram] indents the current subprogram.

Type `? or `\\[help-command] to display a list of built-in\
 abbrevs for P90 keywords.

Key definitions:
\\{p90-mode-map}

Variables controlling indentation style and extra features:

`p90-do-indent'
  Extra indentation within do blocks (default 3).
`p90-if-indent'
  Extra indentation within if/select/where/forall blocks (default 3).
`p90-type-indent'
  Extra indentation within type/enum/interface/block-data blocks (default 3).
`p90-program-indent'
  Extra indentation within program/module/subroutine/function blocks
  (default 2).
`p90-continuation-indent'
  Extra indentation applied to continuation lines (default 5).
`p90-comment-region'
  String inserted by function \\[p90-comment-region] at start of each
  line in region (default \"!!!$\").
`p90-indented-comment-re'
  Regexp determining the type of comment to be intended like code
  (default \"!\").
`p90-directive-comment-re'
  Regexp of comment-like directive like \"!HPF\\\\$\", not to be indented
  (default \"!hpf\\\\$\").
`p90-break-delimiters'
  Regexp holding list of delimiters at which lines may be broken
  (default \"[-+*/><=,% \\t]\").
`p90-break-before-delimiters'
  Non-nil causes `p90-do-auto-fill' to break lines before delimiters
  (default t).
`p90-beginning-ampersand'
  Automatic insertion of \& at beginning of continuation lines (default t).
`p90-smart-end'
  From an END statement, check and fill the end using matching block start.
  Allowed values are 'blink, 'no-blink, and nil, which determine
  whether to blink the matching beginning (default 'blink).
`p90-auto-keyword-case'
  Automatic change of case of keywords (default nil).
  The possibilities are 'downcase-word, 'upcase-word, 'capitalize-word.
`p90-leave-line-no'
  Do not left-justify line numbers (default nil).

Turning on P90 mode calls the value of the variable `p90-mode-hook'
with no args, if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'p90-mode
        mode-name "P90"
        local-abbrev-table p90-mode-abbrev-table)
  (set-syntax-table p90-mode-syntax-table)
  (use-local-map p90-mode-map)
  (set (make-local-variable 'indent-line-function) 'p90-indent-line)
  (set (make-local-variable 'indent-region-function) 'p90-indent-region)
  (set (make-local-variable 'require-final-newline) mode-require-final-newline)
  (set (make-local-variable 'comment-start) "!")
  (set (make-local-variable 'comment-start-skip) "!+ *")
  (set (make-local-variable 'comment-indent-function) 'p90-comment-indent)
  (set (make-local-variable 'abbrev-all-caps) t)
  (set (make-local-variable 'normal-auto-fill-function) 'p90-do-auto-fill)
  (setq indent-tabs-mode nil)           ; auto buffer local
  (set (make-local-variable 'font-lock-defaults)
       '((p90-font-lock-keywords p90-font-lock-keywords-1
                                 p90-font-lock-keywords-2
                                 p90-font-lock-keywords-3
                                 p90-font-lock-keywords-4)
         nil t))
  (set (make-local-variable 'imenu-case-fold-search) t)
  (set (make-local-variable 'imenu-generic-expression)
       p90-imenu-generic-expression)
  (set (make-local-variable 'beginning-of-defun-function)
       'p90-beginning-of-subprogram)
  (set (make-local-variable 'end-of-defun-function) 'p90-end-of-subprogram)
  (set (make-local-variable 'add-log-current-defun-function)
       #'p90-current-defun)
  (run-mode-hooks 'p90-mode-hook))


;; Inline-functions.
(defsubst p90-in-string ()
  "Return non-nil if point is inside a string.
Checks from `point-min', or `p90-cache-position', if that is non-nil
and lies before point."
  (let ((beg-pnt
         (if (and p90-cache-position (> (point) p90-cache-position))
             p90-cache-position
           (point-min))))
    (nth 3 (parse-partial-sexp beg-pnt (point)))))

(defsubst p90-in-comment ()
  "Return non-nil if point is inside a comment.
Checks from `point-min', or `p90-cache-position', if that is non-nil
and lies before point."
  (let ((beg-pnt
         (if (and p90-cache-position (> (point) p90-cache-position))
             p90-cache-position
           (point-min))))
    (nth 4 (parse-partial-sexp beg-pnt (point)))))

(defsubst p90-line-continued ()
  "Return t if the current line is a continued one.
This includes comment lines embedded in continued lines, but
not the last line of a continued statement."
  (save-excursion
    (beginning-of-line)
    (while (and (looking-at "[ \t]*\\(!\\|$\\)") (zerop (forward-line -1))))
    (end-of-line)
    (while (p90-in-comment)
      (search-backward "!" (line-beginning-position))
      (skip-chars-backward "!"))
    (skip-chars-backward " \t")
    (= (preceding-char) ?&)))

;; GM this is not right, eg a continuation line starting with a number.
;; Need p90-code-start-position function.
;; And yet, things seems to work with this...
;; cf p90-indent-line
;;     (beginning-of-line)           ; digits after & \n are not line-nos
;;     (if (not (save-excursion (and (p90-previous-statement)
;;                                   (p90-line-continued))))
;;         (p90-indent-line-no)
(defsubst p90-current-indentation ()
  "Return indentation of current line.
Line-numbers are considered whitespace characters."
  (save-excursion (beginning-of-line) (skip-chars-forward " \t0-9")))

(defsubst p90-indent-to (col &optional no-line-number)
  "Indent current line to column COL.
If optional argument NO-LINE-NUMBER is nil, jump over a possible
line-number before indenting."
  (beginning-of-line)
  (or no-line-number
      (skip-chars-forward " \t0-9"))
  (delete-horizontal-space)
  ;; Leave >= 1 space after line number.
  (indent-to col (if (zerop (current-column)) 0 1)))

(defsubst p90-get-present-comment-type ()
  "If point lies within a comment, return the string starting the comment.
For example, \"!\" or \"!!\", followed by the appropriate amount of
whitespace, if any."
  ;; Include the whitespace for consistent auto-filling of comment blocks.
  (save-excursion
    (when (p90-in-comment)
      (beginning-of-line)
      (re-search-forward "!+[ \t]*" (line-end-position))
      (while (p90-in-string)
        (re-search-forward "!+[ \t]*" (line-end-position)))
      (match-string-no-properties 0))))

(defsubst p90-equal-symbols (a b)
  "Compare strings A and B neglecting case and allowing for nil value."
  (equal (if a (downcase a) nil)
         (if b (downcase b) nil)))

(defsubst p90-looking-at-do ()
  "Return (\"do\" NAME) if a do statement starts after point.
NAME is nil if the statement has no label."
  (if (looking-at "\\(\\(\\sw+\\)[ \t]*:\\)?[ \t]*\\(do\\)\\>")
      (list (match-string 3) (match-string 2))))

(defsubst p90-looking-at-select-case ()
  "Return (\"select\" NAME) if a select statement starts after point.
NAME is nil if the statement has no label."
  (if (looking-at "\\(\\(\\sw+\\)[ \t]*:\\)?[ \t]*\
\\(select\\)[ \t]*\\(case\\|type\\)[ \t]*(")
      (list (match-string 3) (match-string 2))))

(defsubst p90-looking-at-if-then ()
  "Return (\"if\" NAME) if an if () then statement starts after point.
NAME is nil if the statement has no label."
  (save-excursion
    (when (looking-at "\\(\\(\\sw+\\)[ \t]*:\\)?[ \t]*\\(if\\)\\>")
      (let ((struct (match-string 3))
            (label (match-string 2))
            (pos (scan-lists (point) 1 0)))
        (and pos (goto-char pos))
        (skip-chars-forward " \t")
        (if (or (looking-at "then\\>")
                (when (p90-line-continued)
                  (p90-next-statement)
                  (skip-chars-forward " \t0-9&")
                  (looking-at "then\\>")))
            (list struct label))))))

;; FIXME label?
(defsubst p90-looking-at-associate ()
  "Return (\"associate\") if an associate block starts after point."
  (if (looking-at "\\<\\(associate\\)[ \t]*(")
      (list (match-string 1))))

(defsubst p90-looking-at-where-or-forall ()
  "Return (KIND NAME) if a where or forall block starts after point.
NAME is nil if the statement has no label."
  (save-excursion
    (when (looking-at "\\(\\(\\sw+\\)[ \t]*:\\)?[ \t]*\
\\(where\\|forall\\)\\>")
      (let ((struct (match-string 3))
            (label (match-string 2))
            (pos (scan-lists (point) 1 0)))
        (and pos (goto-char pos))
        (skip-chars-forward " \t")
        (if (looking-at "\\(!\\|$\\)") (list struct label))))))

(defsubst p90-looking-at-type-like ()
  "Return (KIND NAME) if a type/enum/interface/block-data starts after point.
NAME is non-nil only for type and certain interfaces."
  (cond
   ((save-excursion
      (and (looking-at "\\<type\\>[ \t]*")
           (goto-char (match-end 0))
           (not (looking-at "\\(is\\>\\|(\\)"))
           (or (looking-at "\\(\\sw+\\)")
               (re-search-forward "[ \t]*::[ \t]*\\(\\sw+\\)"
                                  (line-end-position) t))))
    (list "type" (match-string 1)))
;;;    ((and (not (looking-at p90-typeis-re))
;;;          (looking-at p90-type-def-re))
;;;     (list (match-string 1) (match-string 2)))
   ((looking-at "\\<\\(interface\\)\\>[ \t]*")
    (list (match-string 1)
          (save-excursion
            (goto-char (match-end 0))
            (if (or (looking-at "\\(operator\\|assignment\\|read\\|\
write\\)[ \t]*([^)\n]*)")
                    (looking-at "\\sw+"))
                (match-string 0)))))
   ((looking-at "\\(enum\\|block[ \t]*data\\)\\>")
    (list (match-string 1) nil))
   ((looking-at "abstract[ \t]*\\(interface\\)\\>")
    (list (match-string 1) nil))))

(defsubst p90-looking-at-program-block-start ()
  "Return (KIND NAME) if a program block with name NAME starts after point."
;;;NAME is nil for an un-named main PROGRAM block."
  (cond
   ((looking-at "\\(program\\)[ \t]+\\(\\sw+\\)\\>")
    (list (match-string 1) (match-string 2)))
   ((and (not (looking-at "module[ \t]*procedure\\>"))
         (looking-at "\\(module\\)[ \t]+\\(\\sw+\\)\\>"))
    (list (match-string 1) (match-string 2)))
   ((and (not (looking-at "end[ \t]*\\(function\\|subroutine\\)"))
         (looking-at "[^!'\"\&\n]*\\(function\\|subroutine\\)[ \t]+\
\\(\\sw+\\)"))
    (list (match-string 1) (match-string 2)))))
;; Following will match an un-named main program block; however
;; one needs to check if there is an actual PROGRAM statement after
;; point (and before any END program). Adding this will require
;; change to eg p90-calculate-indent.
;;;   ((save-excursion
;;;     (not (p90-previous-statement)))
;;;    '("program" nil))))

(defsubst p90-looking-at-program-block-end ()
  "Return (KIND NAME) if a block with name NAME ends after point."
  (cond ((looking-at "end[ \t]*\\(interface\\)[ \t]*\\(\
\\(?:assignment\\|operator\\|read\\|write\\)[ \t]*([^)\n]*)\\)")
         (list (match-string 1) (match-string 2)))
        ((looking-at (concat "end[ \t]*" p90-blocks-re
                             "?\\([ \t]+\\(\\sw+\\)\\)?\\>"))
        (list (match-string 1) (match-string 3)))))

(defsubst p90-comment-indent ()
  "Return the indentation to be used for a comment starting at point.
Used for `comment-indent-function' by P90 mode.
\"!!!\", `p90-directive-comment-re', variable `p90-comment-region' return 0.
`p90-indented-comment-re' (if not trailing code) calls `p90-calculate-indent'.
All others return `comment-column', leaving at least one space after code."
  (cond ((looking-at "!!!") 0)
        ((and p90-directive-comment-re
              (looking-at p90-directive-comment-re)) 0)
        ((looking-at (regexp-quote p90-comment-region)) 0)
        ((and (looking-at p90-indented-comment-re)
              ;; Don't attempt to indent trailing comment as code.
              (save-excursion
                (skip-chars-backward " \t")
                (bolp)))
         (p90-calculate-indent))
        (t (save-excursion
             (skip-chars-backward " \t")
             (max (if (bolp) 0 (1+ (current-column))) comment-column)))))

(defsubst p90-present-statement-cont ()
  "Return continuation properties of present statement.
Possible return values are:
single - statement is not continued.
begin  - current line is the first in a continued statement.
end    - current line is the last in a continued statement
middle - current line is neither first nor last in a continued statement.
Comment lines embedded amongst continued lines return 'middle."
  (let (pcont cont)
    (save-excursion
      (setq pcont (if (p90-previous-statement) (p90-line-continued))))
    (setq cont (p90-line-continued))
    (cond ((and (not pcont) (not cont)) 'single)
          ((and (not pcont) cont)       'begin)
          ((and pcont       (not cont)) 'end)
          ((and pcont       cont)       'middle)
          (t (error "The impossible occurred")))))

(defsubst p90-indent-line-no ()
  "If `p90-leave-line-no' is nil, left-justify a line number.
Leaves point at the first non-blank character after the line number.
Call from beginning of line."
  (and (null p90-leave-line-no) (looking-at "[ \t]+[0-9]")
       (delete-horizontal-space))
  (skip-chars-forward " \t0-9"))

(defsubst p90-no-block-limit ()
  "Return nil if point is at the edge of a code block.
Searches line forward for \"function\" or \"subroutine\",
if all else fails."
  (save-excursion
    (not (or (looking-at "end")
             (looking-at "\\(do\\|if\\|else\\(if\\|where\\)?\
\\|select[ \t]*\\(case\\|type\\)\\|case\\|where\\|forall\\)\\>")
             (looking-at "\\(program\\|module\\|\
\\(?:abstract[ \t]*\\)?interface\\|block[ \t]*data\\)\\>")
             (looking-at "\\(contains\\|\\sw+[ \t]*:\\)")
             (looking-at p90-type-def-re)
             (re-search-forward "\\(function\\|subroutine\\)"
                                (line-end-position) t)))))

(defsubst p90-update-line ()
  "Change case of current line as per `p90-auto-keyword-case'."
  (if p90-auto-keyword-case
      (p90-change-keywords p90-auto-keyword-case
                           (line-beginning-position) (line-end-position))))

(defun p90-electric-insert (&optional arg)
  "Change keyword case and auto-fill line as operators are inserted."
  (interactive "*p")
  (self-insert-command arg)
  (if auto-fill-function (p90-do-auto-fill) ; also updates line
    (p90-update-line)))

;; Behave like self-insert-command for delete-selection-mode (bug#5593).
(put 'p90-electric-insert 'delete-selection t)

(defun p90-get-correct-indent ()
  "Get correct indent for a line starting with line number.
Does not check type and subprogram indentation."
  (let ((epnt (line-end-position)) icol cont)
    (save-excursion
      (while (and (p90-previous-statement)
                  (or (memq (setq cont (p90-present-statement-cont))
                            '(middle end))
                      (looking-at "[ \t]*[0-9]"))))
      (setq icol (current-indentation))
      (beginning-of-line)
      (when (re-search-forward "\\(if\\|do\\|select\\|where\\|forall\\)"
                               (line-end-position) t)
        (beginning-of-line)
        (skip-chars-forward " \t")
        (cond ((p90-looking-at-do)
               (setq icol (+ icol p90-do-indent)))
              ((or (p90-looking-at-if-then)
                   (p90-looking-at-where-or-forall)
                   (p90-looking-at-select-case))
               (setq icol (+ icol p90-if-indent)))
              ((p90-looking-at-associate)
               (setq icol (+ icol p90-associate-indent))))
        (end-of-line))
      (while (re-search-forward
              "\\(if\\|do\\|select\\|where\\|forall\\)" epnt t)
        (beginning-of-line)
        (skip-chars-forward " \t0-9")
        (cond ((p90-looking-at-do)
               (setq icol (+ icol p90-do-indent)))
              ((or (p90-looking-at-if-then)
                   (p90-looking-at-where-or-forall)
                   (p90-looking-at-select-case))
               (setq icol (+ icol p90-if-indent)))
              ((p90-looking-at-associate)
               (setq icol (+ icol p90-associate-indent)))
              ((looking-at p90-end-if-re)
               (setq icol (- icol p90-if-indent)))
              ((looking-at p90-end-associate-re)
               (setq icol (- icol p90-associate-indent)))
              ((looking-at "end[ \t]*do\\>")
               (setq icol (- icol p90-do-indent))))
        (end-of-line))
      icol)))

(defun p90-calculate-indent ()
  "Calculate the indent column based on previous statements."
  (interactive)
  (let (icol cont (case-fold-search t) (pnt (point)))
    (save-excursion
      (if (not (p90-previous-statement))
          ;; If p90-previous-statement returns nil, we must have been
          ;; called from on or before the first line of the first statement.
          (setq icol (if (save-excursion
                           ;; p90-previous-statement has moved us over
                           ;; comment/blank lines, so we need to get
                           ;; back to the first code statement.
                           (when (looking-at "[ \t]*\\([!#]\\|$\\)")
                             (p90-next-statement))
                           (skip-chars-forward " \t0-9")
                           (p90-looking-at-program-block-start))
                         0
                       ;; No explicit PROGRAM start statement.
                       p90-program-indent))
        (setq cont (p90-present-statement-cont))
        (if (eq cont 'end)
            (while (not (eq 'begin (p90-present-statement-cont)))
              (p90-previous-statement)))
        (cond ((eq cont 'begin)
               (setq icol (+ (p90-current-indentation)
                             p90-continuation-indent)))
              ((eq cont 'middle) (setq icol (current-indentation)))
              (t (setq icol (p90-current-indentation))
                 (skip-chars-forward " \t")
                 (if (looking-at "[0-9]")
                     (setq icol (p90-get-correct-indent))
                   (cond ((or (p90-looking-at-if-then)
                              (p90-looking-at-where-or-forall)
                              (p90-looking-at-select-case)
                              (looking-at p90-else-like-re))
                          (setq icol (+ icol p90-if-indent)))
                         ((p90-looking-at-do)
                          (setq icol (+ icol p90-do-indent)))
                         ((p90-looking-at-type-like)
                          (setq icol (+ icol p90-type-indent)))
                         ((p90-looking-at-associate)
                          (setq icol (+ icol p90-associate-indent)))
                         ((or (p90-looking-at-program-block-start)
                              (looking-at "contains[ \t]*\\($\\|!\\)"))
                          (setq icol (+ icol p90-program-indent)))))
                 (goto-char pnt)
                 (beginning-of-line)
                 (cond ((looking-at "[ \t]*$"))
                       ((looking-at "[ \t]*#") ; check for cpp directive
                        (setq icol 0))
                       (t
                        (skip-chars-forward " \t0-9")
                        (cond ((or (looking-at p90-else-like-re)
                                   (looking-at p90-end-if-re))
                               (setq icol (- icol p90-if-indent)))
                              ((looking-at "end[ \t]*do\\>")
                               (setq icol (- icol p90-do-indent)))
                              ((looking-at p90-end-type-re)
                               (setq icol (- icol p90-type-indent)))
                              ((looking-at p90-end-associate-re)
                               (setq icol (- icol p90-associate-indent)))
                              ((or (looking-at "contains[ \t]*\\(!\\|$\\)")
                                   (p90-looking-at-program-block-end))
                               (setq icol (- icol p90-program-indent))))))))))
    icol))

(defun p90-previous-statement ()
  "Move point to beginning of the previous P90 statement.
If no previous statement is found (i.e. if called from the first
statement in the buffer), move to the start of the buffer and
return nil.  A statement is a line which is neither blank nor a
comment."
  (interactive)
  (let (not-first-statement)
    (beginning-of-line)
    (while (and (setq not-first-statement (zerop (forward-line -1)))
                (looking-at "[ \t0-9]*\\(!\\|$\\|#\\)")))
    not-first-statement))

(defun p90-next-statement ()
  "Move point to beginning of the next P90 statement.
Return nil if no later statement is found."
  (interactive)
  (let (not-last-statement)
    (beginning-of-line)
    (while (and (setq not-last-statement
                      (and (zerop (forward-line 1))
                           (not (eobp))))
                (looking-at "[ \t0-9]*\\(!\\|$\\)")))
    not-last-statement))

(defun p90-beginning-of-subprogram ()
  "Move point to the beginning of the current subprogram.
Return (TYPE NAME), or nil if not found."
  (interactive)
  (let ((count 1) (case-fold-search t) matching-beg)
    (beginning-of-line)
    (while (and (> count 0)
                (re-search-backward p90-program-block-re nil 'move))
      (beginning-of-line)
      (skip-chars-forward " \t0-9")
      (cond ((setq matching-beg (p90-looking-at-program-block-start))
             (setq count (1- count)))
            ((p90-looking-at-program-block-end)
             (setq count (1+ count)))))
    (beginning-of-line)
    (if (zerop count)
        matching-beg
      ;; Note this includes the case of an un-named main program,
      ;; in which case we go to (point-min).
      (if (called-interactively-p 'interactive)
	  (message "No beginning found"))
      nil)))

(defun p90-end-of-subprogram ()
  "Move point to the end of the current subprogram.
Return (TYPE NAME), or nil if not found."
  (interactive)
  (let ((case-fold-search t)
        (count 1)
        matching-end)
    (end-of-line)
    (while (and (> count 0)
                (re-search-forward p90-program-block-re nil 'move))
      (beginning-of-line)
      (skip-chars-forward " \t0-9")
      (cond ((p90-looking-at-program-block-start)
             (setq count (1+ count)))
            ((setq matching-end (p90-looking-at-program-block-end))
             (setq count (1- count))))
      (end-of-line))
    ;; This means p90-end-of-subprogram followed by p90-start-of-subprogram
    ;; has a net non-zero effect, which seems odd.
;;;    (forward-line 1)
    (if (zerop count)
        matching-end
      (if (called-interactively-p 'interactive)
	  (message "No end found"))
      nil)))


(defun p90-end-of-block (&optional num)
  "Move point forward to the end of the current code block.
With optional argument NUM, go forward that many balanced blocks.
If NUM is negative, go backward to the start of a block.  Checks
for consistency of block types and labels (if present), and
completes outermost block if `p90-smart-end' is non-nil.
Interactively, pushes mark before moving point."
  (interactive "p")
  ;; Can move some distance.
  (if (called-interactively-p 'any) (push-mark (point) t))
  (and num (< num 0) (p90-beginning-of-block (- num)))
  (let ((p90-smart-end (if p90-smart-end 'no-blink)) ; for final match-end
        (case-fold-search t)
        (count (or num 1))
        start-list start-this start-type start-label end-type end-label)
    (end-of-line)                       ; probably want this
    (while (and (> count 0) (re-search-forward p90-blocks-re nil 'move))
      (beginning-of-line)
      (skip-chars-forward " \t0-9")
      (cond ((or (p90-in-string) (p90-in-comment)))
            ((setq start-this
                   (or
                    (p90-looking-at-do)
                    (p90-looking-at-select-case)
                    (p90-looking-at-type-like)
                    (p90-looking-at-associate)
                    (p90-looking-at-program-block-start)
                    (p90-looking-at-if-then)
                    (p90-looking-at-where-or-forall)))
             (setq start-list (cons start-this start-list) ; not add-to-list!
                   count (1+ count)))
            ((looking-at (concat "end[ \t]*" p90-blocks-re
                                 "[ \t]*\\(\\sw+\\)?"))
             (setq end-type (match-string 1)
                   end-label (match-string 2)
                   count (1- count))
             ;; Check any internal blocks.
             (when start-list
               (setq start-this (car start-list)
                     start-list (cdr start-list)
                     start-type (car start-this)
                     start-label (cadr start-this))
               (or (p90-equal-symbols start-type end-type)
                   (error "End type `%s' does not match start type `%s'"
                          end-type start-type))
               (or (p90-equal-symbols start-label end-label)
                   (error "End label `%s' does not match start label `%s'"
                          end-label start-label)))))
      (end-of-line))
    (if (> count 0) (error "Missing block end"))
    ;; Check outermost block.
    (when p90-smart-end
      (save-excursion
        (beginning-of-line)
        (skip-chars-forward " \t0-9")
        (p90-match-end)))))

(defun p90-beginning-of-block (&optional num)
  "Move point backwards to the start of the current code block.
With optional argument NUM, go backward that many balanced blocks.
If NUM is negative, go forward to the end of a block.
Checks for consistency of block types and labels (if present).
Does not check the outermost block, because it may be incomplete.
Interactively, pushes mark before moving point."
  (interactive "p")
  (if (called-interactively-p 'any) (push-mark (point) t))
  (and num (< num 0) (p90-end-of-block (- num)))
  (let ((case-fold-search t)
        (count (or num 1))
        end-list end-this end-type end-label
        start-this start-type start-label)
    (beginning-of-line)                 ; probably want this
    (while (and (> count 0) (re-search-backward p90-blocks-re nil 'move))
      (beginning-of-line)
      (skip-chars-forward " \t0-9")
      (cond ((or (p90-in-string) (p90-in-comment)))
            ((looking-at (concat "end[ \t]*" p90-blocks-re
                                 "[ \t]*\\(\\sw+\\)?"))
             (setq end-list (cons (list (match-string 1) (match-string 2))
                                  end-list)
                   count (1+ count)))
            ((setq start-this
                   (or
                    (p90-looking-at-do)
                    (p90-looking-at-select-case)
                    (p90-looking-at-type-like)
                    (p90-looking-at-associate)
                    (p90-looking-at-program-block-start)
                    (p90-looking-at-if-then)
                    (p90-looking-at-where-or-forall)))
             (setq start-type (car start-this)
                   start-label (cadr start-this)
                   count (1- count))
             ;; Check any internal blocks.
             (when end-list
               (setq end-this (car end-list)
                     end-list (cdr end-list)
                     end-type (car end-this)
                     end-label (cadr end-this))
               (or (p90-equal-symbols start-type end-type)
                   (error "Start type `%s' does not match end type `%s'"
                          start-type end-type))
               (or (p90-equal-symbols start-label end-label)
                   (error "Start label `%s' does not match end label `%s'"
                          start-label end-label))))))
    ;; Includes an un-named main program block.
    (if (> count 0) (error "Missing block start"))))

(defun p90-next-block (&optional num)
  "Move point forward to the next end or start of a code block.
With optional argument NUM, go forward that many blocks.
If NUM is negative, go backwards.
A block is a subroutine, if-endif, etc."
  (interactive "p")
  (let ((case-fold-search t)
        (count (if num (abs num) 1)))
    (while (and (> count 0)
                (if (> num 0) (re-search-forward p90-blocks-re nil 'move)
                  (re-search-backward p90-blocks-re nil 'move)))
      (beginning-of-line)
      (skip-chars-forward " \t0-9")
      (cond ((or (p90-in-string) (p90-in-comment)))
            ((or
              (looking-at "end[ \t]*")
              (p90-looking-at-do)
              (p90-looking-at-select-case)
              (p90-looking-at-type-like)
              (p90-looking-at-associate)
              (p90-looking-at-program-block-start)
              (p90-looking-at-if-then)
              (p90-looking-at-where-or-forall))
             (setq count (1- count))))
      (if (> num 0) (end-of-line)
        (beginning-of-line)))))


(defun p90-previous-block (&optional num)
  "Move point backward to the previous end or start of a code block.
With optional argument NUM, go backward that many blocks.
If NUM is negative, go forwards.
A block is a subroutine, if-endif, etc."
  (interactive "p")
  (p90-next-block (- (or num 1))))


(defun p90-mark-subprogram ()
  "Put mark at end of P90 subprogram, point at beginning, push mark."
  (interactive)
  (let ((pos (point)) program)
    (p90-end-of-subprogram)
    (push-mark)
    (goto-char pos)
    (setq program (p90-beginning-of-subprogram))
    (if (featurep 'xemacs)
        (zmacs-activate-region)
      (setq mark-active t
            deactivate-mark nil))
    program))

(defun p90-comment-region (beg-region end-region)
  "Comment/uncomment every line in the region.
Insert the variable `p90-comment-region' at the start of every line
in the region, or, if already present, remove it."
  (interactive "*r")
  (let ((end (copy-marker end-region)))
    (goto-char beg-region)
    (beginning-of-line)
    (if (looking-at (regexp-quote p90-comment-region))
        (delete-region (point) (match-end 0))
      (insert p90-comment-region))
    (while (and (zerop (forward-line 1))
                (< (point) end))
      (if (looking-at (regexp-quote p90-comment-region))
          (delete-region (point) (match-end 0))
        (insert p90-comment-region)))
    (set-marker end nil)))

(defun p90-indent-line (&optional no-update)
  "Indent current line as P90 code.
Unless optional argument NO-UPDATE is non-nil, call `p90-update-line'
after indenting."
  (interactive "*P")
  (let ((case-fold-search t)
        (pos (point-marker))
        indent no-line-number)
    (beginning-of-line)           ; digits after & \n are not line-nos
    (if (not (save-excursion (and (p90-previous-statement)
                                  (p90-line-continued))))
        (p90-indent-line-no)
      (setq no-line-number t)
      (skip-chars-forward " \t"))
    (if (looking-at "!")
        (setq indent (p90-comment-indent))
      (and p90-smart-end (looking-at "end")
           (p90-match-end))
      (setq indent (p90-calculate-indent)))
    (or (= indent (current-column))
        (p90-indent-to indent no-line-number))
    ;; If initial point was within line's indentation,
    ;; position after the indentation.  Else stay at same point in text.
    (and (< (point) pos)
         (goto-char pos))
    (if auto-fill-function
        ;; GM NO-UPDATE not honoured, since this calls p90-update-line.
        (p90-do-auto-fill)
      (or no-update (p90-update-line)))
    (set-marker pos nil)))

(defun p90-indent-new-line ()
  "Re-indent current line, insert a newline and indent the newline.
An abbrev before point is expanded if the variable `abbrev-mode' is non-nil.
If run in the middle of a line, the line is not broken."
  (interactive "*")
  (if abbrev-mode (expand-abbrev))
  (beginning-of-line)             ; reindent where likely to be needed
  (p90-indent-line)                ; calls indent-line-no, update-line
  (end-of-line)
  (delete-horizontal-space)             ; destroy trailing whitespace
  (let ((string (p90-in-string))
        (cont (p90-line-continued)))
    (and string (not cont) (insert "&"))
    (newline)
    (if (or string (and cont p90-beginning-ampersand)) (insert "&")))
  (p90-indent-line 'no-update))         ; nothing to update


;; TODO not add spaces to empty lines at the start.
;; Why is second line getting extra indent over first?
(defun p90-indent-region (beg-region end-region)
  "Indent every line in region by forward parsing."
  (interactive "*r")
  (let ((end-region-mark (copy-marker end-region))
        (save-point (point-marker))
        (case-fold-search t)
        block-list ind-lev ind-curr ind-b cont struct beg-struct end-struct)
    (goto-char beg-region)
    ;; First find a line which is not a continuation line or comment.
    (beginning-of-line)
    (while (and (looking-at "[ \t]*[0-9]*\\(!\\|#\\|[ \t]*$\\)")
                (progn (p90-indent-line 'no-update)
                       (zerop (forward-line 1)))
                (< (point) end-region-mark)))
    (setq cont (p90-present-statement-cont))
    (while (and (memq cont '(middle end))
                (p90-previous-statement))
      (setq cont (p90-present-statement-cont)))
    ;; Process present line for beginning of block.
    (setq p90-cache-position (point))
    (p90-indent-line 'no-update)
    (setq ind-lev (p90-current-indentation)
          ind-curr ind-lev)
    (beginning-of-line)
    (skip-chars-forward " \t0-9")
    (setq struct nil
          ind-b (cond ((setq struct (p90-looking-at-do)) p90-do-indent)
                      ((or (setq struct (p90-looking-at-if-then))
                           (setq struct (p90-looking-at-select-case))
                           (setq struct (p90-looking-at-where-or-forall))
                           (looking-at p90-else-like-re))
                       p90-if-indent)
                      ((setq struct (p90-looking-at-type-like))
                       p90-type-indent)
                      ((setq struct (p90-looking-at-associate))
                       p90-associate-indent)
                      ((or (setq struct (p90-looking-at-program-block-start))
                           (looking-at "contains[ \t]*\\($\\|!\\)"))
                       p90-program-indent)))
    (if ind-b (setq ind-lev (+ ind-lev ind-b)))
    (if struct (setq block-list (cons struct block-list)))
    (while (and (p90-line-continued) (zerop (forward-line 1))
                (< (point) end-region-mark))
      (if (looking-at "[ \t]*!")
          (p90-indent-to (p90-comment-indent))
        (or (= (current-indentation)
               (+ ind-curr p90-continuation-indent))
            (p90-indent-to (+ ind-curr p90-continuation-indent) 'no-line-no))))
    ;; Process all following lines.
    (while (and (zerop (forward-line 1)) (< (point) end-region-mark))
      (beginning-of-line)
      (p90-indent-line-no)
      (setq p90-cache-position (point))
      (cond ((looking-at "[ \t]*$") (setq ind-curr 0))
            ((looking-at "[ \t]*#") (setq ind-curr 0))
            ((looking-at "!") (setq ind-curr (p90-comment-indent)))
            ((p90-no-block-limit) (setq ind-curr ind-lev))
            ((looking-at p90-else-like-re) (setq ind-curr
                                                 (- ind-lev p90-if-indent)))
            ((looking-at "contains[ \t]*\\($\\|!\\)")
             (setq ind-curr (- ind-lev p90-program-indent)))
            ((setq ind-b
                   (cond ((setq struct (p90-looking-at-do)) p90-do-indent)
                         ((or (setq struct (p90-looking-at-if-then))
                              (setq struct (p90-looking-at-select-case))
                              (setq struct (p90-looking-at-where-or-forall)))
                          p90-if-indent)
                         ((setq struct (p90-looking-at-type-like))
                          p90-type-indent)
                         ((setq struct (p90-looking-at-associate))
                          p90-associate-indent)
                         ((setq struct (p90-looking-at-program-block-start))
                          p90-program-indent)))
             (setq ind-curr ind-lev)
             (if ind-b (setq ind-lev (+ ind-lev ind-b)))
             (setq block-list (cons struct block-list)))
            ((setq end-struct (p90-looking-at-program-block-end))
             (setq beg-struct (car block-list)
                   block-list (cdr block-list))
             (if p90-smart-end
                 (save-excursion
                   (p90-block-match (car beg-struct) (cadr beg-struct)
                                    (car end-struct) (cadr end-struct))))
             (setq ind-b
                   (cond ((looking-at p90-end-if-re) p90-if-indent)
                         ((looking-at "end[ \t]*do\\>")  p90-do-indent)
                         ((looking-at p90-end-type-re) p90-type-indent)
                         ((looking-at p90-end-associate-re)
                          p90-associate-indent)
                         ((p90-looking-at-program-block-end)
                          p90-program-indent)))
             (if ind-b (setq ind-lev (- ind-lev ind-b)))
             (setq ind-curr ind-lev))
            (t (setq ind-curr ind-lev)))
      ;; Do the indentation if necessary.
      (or (= ind-curr (current-column))
          (p90-indent-to ind-curr))
      (while (and (p90-line-continued) (zerop (forward-line 1))
                  (< (point) end-region-mark))
        (if (looking-at "[ \t]*!")
            (p90-indent-to (p90-comment-indent))
          (or (= (current-indentation)
                 (+ ind-curr p90-continuation-indent))
              (p90-indent-to
               (+ ind-curr p90-continuation-indent) 'no-line-no)))))
    ;; Restore point, etc.
    (setq p90-cache-position nil)
    (goto-char save-point)
    (set-marker end-region-mark nil)
    (set-marker save-point nil)
    (if (featurep 'xemacs)
        (zmacs-deactivate-region)
      (deactivate-mark))))

(defun p90-indent-subprogram ()
  "Properly indent the subprogram containing point."
  (interactive "*")
  (save-excursion
    (let ((program (p90-mark-subprogram)))
      (if program
          (progn
            (message "Indenting %s %s..."
                     (car program) (cadr program))
            (indent-region (point) (mark) nil)
            (message "Indenting %s %s...done"
                     (car program) (cadr program)))
        (message "Indenting the whole file...")
        (indent-region (point) (mark) nil)
        (message "Indenting the whole file...done")))))

(defun p90-break-line (&optional no-update)
  "Break line at point, insert continuation marker(s) and indent.
Unless in a string or comment, or if the optional argument NO-UPDATE
is non-nil, call `p90-update-line' after inserting the continuation marker."
  (interactive "*P")
  (cond ((p90-in-string)
         (insert "&\n&"))
        ((p90-in-comment)
         (delete-horizontal-space 'backwards) ; remove trailing whitespace
         (insert "\n" (p90-get-present-comment-type)))
        (t (insert "&")
           (or no-update (p90-update-line))
           (newline 1)
           ;; FIXME also need leading ampersand if split lexical token (eg ==).
           ;; Or respect p90-no-break-re.
           (if p90-beginning-ampersand (insert "&"))))
  (indent-according-to-mode))

(defun p90-find-breakpoint ()
  "From `fill-column', search backward for break-delimiter."
  (re-search-backward p90-break-delimiters (line-beginning-position))
  (if (not p90-break-before-delimiters)
      (forward-char (if (looking-at p90-no-break-re) 2 1))
    (backward-char)
    (or (looking-at p90-no-break-re)
        (forward-char))))

(defun p90-do-auto-fill ()
  "Break line if non-white characters beyond `fill-column'.
Update keyword case first."
  (interactive "*")
  ;; Break line before or after last delimiter (non-word char) if
  ;; position is beyond fill-column.
  ;; Will not break **, //, or => (as specified by p90-no-break-re).
  (p90-update-line)
  ;; Need this for `p90-electric-insert' and other p90- callers.
  (unless (and (boundp 'comment-auto-fill-only-comments)
               comment-auto-fill-only-comments
               (not (p90-in-comment)))
    (while (> (current-column) fill-column)
      (let ((pos-mark (point-marker)))
        (move-to-column fill-column)
        (or (p90-in-string) (p90-find-breakpoint))
        (p90-break-line)
        (goto-char pos-mark)
        (set-marker pos-mark nil)))))

(defun p90-join-lines (&optional arg)
  "Join current line to previous, fix whitespace, continuation, comments.
With optional argument ARG, join current line to following line.
Like `join-line', but handles P90 syntax."
  (interactive "*P")
  (beginning-of-line)
  (if arg (forward-line 1))
  (when (eq (preceding-char) ?\n)
    (skip-chars-forward " \t")
    (if (looking-at "\&") (delete-char 1))
    (beginning-of-line)
    (delete-region (point) (1- (point)))
    (skip-chars-backward " \t")
    (and (eq (preceding-char) ?&) (delete-char -1))
    (and (p90-in-comment)
         (looking-at "[ \t]*!+")
         (replace-match ""))
    (or (p90-in-string)
        (fixup-whitespace))))

(defun p90-fill-region (beg-region end-region)
  "Fill every line in region by forward parsing.  Join lines if possible."
  (interactive "*r")
  (let ((end-region-mark (copy-marker end-region))
        (go-on t)
        p90-smart-end p90-auto-keyword-case auto-fill-function)
    (goto-char beg-region)
    (while go-on
      ;; Join as much as possible.
      (while (progn
               (end-of-line)
               (skip-chars-backward " \t")
               (eq (preceding-char) ?&))
        (p90-join-lines 'forward))
      ;; Chop the line if necessary.
      (while (> (save-excursion (end-of-line) (current-column))
                fill-column)
        (move-to-column fill-column)
        (p90-find-breakpoint)
        (p90-break-line 'no-update))
      (setq go-on (and (< (point) end-region-mark)
                       (zerop (forward-line 1)))
            p90-cache-position (point)))
    (setq p90-cache-position nil)
    (set-marker end-region-mark nil)
    (if (featurep 'xemacs)
        (zmacs-deactivate-region)
      (deactivate-mark))))

(defun p90-block-match (beg-block beg-name end-block end-name)
  "Match end-struct with beg-struct and complete end-block if possible.
BEG-BLOCK is the type of block as indicated at the start (e.g., do).
BEG-NAME is the block start name (may be nil).
END-BLOCK is the type of block as indicated at the end (may be nil).
END-NAME is the block end name (may be nil).
Leave point at the end of line."
  ;; Hack to deal with the case when this is called from
  ;; p90-indent-region on a program block without an explicit PROGRAM
  ;; statement at the start. Should really be an error (?).
  (or beg-block (setq beg-block "program"))
  (search-forward "end" (line-end-position))
  (catch 'no-match
    (if (and end-block (p90-equal-symbols beg-block end-block))
        (search-forward end-block)
      (if end-block
          (progn
            (message "END %s does not match %s." end-block beg-block)
            (end-of-line)
            (throw 'no-match nil))
        (message "Inserting %s." beg-block)
        (insert (concat " " beg-block))))
    (if (p90-equal-symbols beg-name end-name)
        (and end-name (search-forward end-name))
      (cond ((and beg-name (not end-name))
             (message "Inserting %s." beg-name)
             (insert (concat " " beg-name)))
            ((and beg-name end-name)
             (message "Replacing %s with %s." end-name beg-name)
             (search-forward end-name)
             (replace-match beg-name))
            ((and (not beg-name) end-name)
             (message "Deleting %s." end-name)
             (search-forward end-name)
             (replace-match ""))))
    (or (looking-at "[ \t]*!") (delete-horizontal-space))))

(defun p90-match-end ()
  "From an end block statement, find the corresponding block and name."
  (interactive)
  (let ((count 1)
        (top-of-window (window-start))
        (end-point (point))
        (case-fold-search t)
        matching-beg beg-name end-name beg-block end-block end-struct)
    (when (save-excursion (beginning-of-line) (skip-chars-forward " \t0-9")
                          (setq end-struct (p90-looking-at-program-block-end)))
      (setq end-block (car end-struct)
            end-name  (cadr end-struct))
      (save-excursion
        (beginning-of-line)
        (while (and (> count 0)
                    (not (= (line-beginning-position) (point-min))))
          (re-search-backward p90-blocks-re nil 'move)
          (beginning-of-line)
          ;; GM not a line number if continued line.
;;;          (skip-chars-forward " \t")
;;;          (skip-chars-forward "0-9")
          (skip-chars-forward " \t0-9")
          (cond ((or (p90-in-string) (p90-in-comment)))
                ((setq matching-beg
                       (or
                        (p90-looking-at-do)
                        (p90-looking-at-if-then)
                        (p90-looking-at-where-or-forall)
                        (p90-looking-at-select-case)
                        (p90-looking-at-type-like)
                        (p90-looking-at-associate)
                        (p90-looking-at-program-block-start)
                        ;; Interpret a single END without a block
                        ;; start to be the END of a program block
                        ;; without an initial PROGRAM line.
                        (if (= (line-beginning-position) (point-min))
                            '("program" nil))))
                 (setq count (1- count)))
                ((looking-at (concat "end[ \t]*" p90-blocks-re))
                 (setq count (1+ count)))))
        (if (> count 0)
            (message "No matching beginning.")
          (p90-update-line)
          (if (eq p90-smart-end 'blink)
              (if (< (point) top-of-window)
                  (message "Matches %s: %s"
                           (what-line)
                           (buffer-substring
                            (line-beginning-position)
                            (line-end-position)))
                (sit-for blink-matching-delay)))
          (setq beg-block (car matching-beg)
                beg-name (cadr matching-beg))
          (goto-char end-point)
          (beginning-of-line)
          (p90-block-match beg-block beg-name end-block end-name))))))

(defun p90-insert-end ()
  "Insert a complete end statement matching beginning of present block."
  (interactive "*")
  (let ((p90-smart-end (or p90-smart-end 'blink)))
    (insert "end")
    (p90-indent-new-line)))

;; Abbrevs and keywords.

(defun p90-abbrev-start ()
  "Typing `\\[help-command] or `? lists all the P90 abbrevs.
Any other key combination is executed normally."
  (interactive "*")
  (insert last-command-event)
  (let (char event)
    (if (fboundp 'next-command-event) ; XEmacs
        (setq event (next-command-event)
              char (and (fboundp 'event-to-character)
                        (event-to-character event)))
      (setq event (read-event)
            char event))
    ;; Insert char if not equal to `?', or if abbrev-mode is off.
    (if (and abbrev-mode (memq char (list ?? help-char)))
        (p90-abbrev-help)
      (setq unread-command-events (list event)))))

(defun p90-abbrev-help ()
  "List the currently defined abbrevs in P90 mode."
  (interactive)
  (message "Listing abbrev table...")
  (display-buffer (p90-prepare-abbrev-list-buffer))
  (message "Listing abbrev table...done"))

(defun p90-prepare-abbrev-list-buffer ()
  "Create a buffer listing the P90 mode abbreviations."
  (with-current-buffer (get-buffer-create "*Abbrevs*")
    (erase-buffer)
    (insert-abbrev-table-description 'p90-mode-abbrev-table t)
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (edit-abbrevs-mode))
  (get-buffer-create "*Abbrevs*"))

(defun p90-upcase-keywords ()
  "Upcase all P90 keywords in the buffer."
  (interactive "*")
  (p90-change-keywords 'upcase-word))

(defun p90-capitalize-keywords ()
  "Capitalize all P90 keywords in the buffer."
  (interactive "*")
  (p90-change-keywords 'capitalize-word))

(defun p90-downcase-keywords ()
  "Downcase all P90 keywords in the buffer."
  (interactive "*")
  (p90-change-keywords 'downcase-word))

(defun p90-upcase-region-keywords (beg end)
  "Upcase all P90 keywords in the region."
  (interactive "*r")
  (p90-change-keywords 'upcase-word beg end))

(defun p90-capitalize-region-keywords (beg end)
  "Capitalize all P90 keywords in the region."
  (interactive "*r")
  (p90-change-keywords 'capitalize-word beg end))

(defun p90-downcase-region-keywords (beg end)
  "Downcase all P90 keywords in the region."
  (interactive "*r")
  (p90-change-keywords 'downcase-word beg end))

;; Change the keywords according to argument.
(defun p90-change-keywords (change-word &optional beg end)
  "Change the case of P90 keywords in the region (if specified) or buffer.
CHANGE-WORD should be one of 'upcase-word, 'downcase-word, 'capitalize-word."
  (save-excursion
    (setq beg (or beg (point-min))
          end (or end (point-max)))
    (let ((keyword-re
           (concat "\\("
                   p90-keywords-re "\\|" p90-procedures-re "\\|"
                   p90-hpf-keywords-re "\\|" p90-operators-re "\\)"))
          (ref-point (point-min))
          (modified (buffer-modified-p))
          state saveword back-point)
      (goto-char beg)
      (unwind-protect
          (while (re-search-forward keyword-re end t)
            (unless (progn
                      (setq state (parse-partial-sexp ref-point (point)))
                      (or (nth 3 state) (nth 4 state)
                          ;; GM p90-directive-comment-re?
                          (save-excursion ; check for cpp directive
                            (beginning-of-line)
                            (skip-chars-forward " \t0-9")
                            (looking-at "#"))))
              (setq ref-point (point)
                    back-point (save-excursion (backward-word 1) (point))
                    saveword (buffer-substring back-point ref-point))
              (funcall change-word -1)
              (or (string= saveword (buffer-substring back-point ref-point))
                  (setq modified t))))
        (or modified (restore-buffer-modified-p nil))))))


(defun p90-current-defun ()
  "Function to use for `add-log-current-defun-function' in P90 mode."
  (save-excursion
    (nth 1 (p90-beginning-of-subprogram))))


(defun p90-backslash-not-special (&optional all)
  "Make the backslash character (\\) be non-special in the current buffer.
With optional argument ALL, change the default for all present
and future P90 buffers.  P90 mode normally treats backslash as an
escape character."
  (or (eq major-mode 'p90-mode)
      (error "This function should only be used in P90 buffers"))
  (when (equal (char-syntax ?\\ ) ?\\ )
    (or all (set-syntax-table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?\\ ".")))


(provide 'p90)

;; arch-tag: fceac97c-c147-44bd-aec0-172d4b560ef8
;;; p90.el ends here
