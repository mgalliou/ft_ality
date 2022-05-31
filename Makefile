NAME          = ft_ality
CHECK         = check
RM            = rm -rf
OCAMLC        = ocamlc
OCAMLOPT      = ocamlopt
OCAMLFIND     = ocamlfind
INCLUDES      = -I $(SRC_DIR) -I $(TST_DIR) -I $(OBJ_DIR)
OCAMLTOPFLAGS = $(INCLUDES) -linkpkg -package sdl2
SRC_DIR       = src
TST_DIR       = test
OBJ_DIR       = obj
SRC_NAME      = \
				move.ml\
				combo.ml\
				state.ml\
		        parser.ml\
		        machine.ml\
		        game.ml\
		        ft_ality.ml
INT_NAME      = $(SRC_NAME:.ml=.mli)
TST_NAME      = \
                test.ml
OBJ_NAME      = $(SRC_NAME:.ml=.cmx)
INT_OBJ_NAME  = $(INT_NAME:.mli=.cmi)
TST_OBJ_NAME  = $(TST_NAME:.ml=.cmx)
SRC           = $(addprefix $(SRC_DIR)/,$(SRC_NAME))
INT           = $(SRC:.ml=.mli)
TST           = $(addprefix $(TST_DIR)/,$(TST_NAME))
OBJ           = $(addprefix $(OBJ_DIR)/,$(OBJ_NAME))
INT_OBJ       = $(addprefix $(OBJ_DIR)/,$(INT_OBJ_NAME))
TST_OBJ       = $(addprefix $(OBJ_DIR)/,$(TST_OBJ_NAME))

all: $(NAME)

$(NAME): $(INT_OBJ) $(OBJ)
	$(OCAMLFIND) $(OCAMLOPT) $(OCAMLTOPFLAGS) $(OBJ) -o $(NAME)

$(OBJ_DIR)/%.cmi : $(SRC_DIR)/%.mli
	mkdir -p $(dir $@)
	$(OCAMLFIND) $(OCAMLC) $(OCAMLTOPFLAGS) -c $< -o $@

$(OBJ_DIR)/%.cmx : $(SRC_DIR)/%.ml
	mkdir -p $(dir $@)
	$(OCAMLFIND) $(OCAMLOPT) $(OCAMLTOPFLAGS) -c $< -o $@

$(OBJ_DIR)/%.cmx : $(TST_DIR)/%.ml
	mkdir -p $(dir $@)
	$(OCAMLFIND) $(OCAMLOPT) $(OCAMLTOPFLAGS) -c $< -o $@

check: $(OBJ) $(TST_OBJ)
	$(OCAMLFIND) $(OCAMLOPT) $(OCAMLTOPFLAGS) $(subst $(OBJ_DIR)/$(NAME).cmx, ,$(OBJ)) $(TST_OBJ) -o $(CHECK)
	./$(CHECK)

clean:
	$(RM) $(OBJ_DIR)

fclean: clean
	$(RM) $(NAME)
	$(RM) $(CHECK)

re: fclean all

.PHONY: all check clean fclean re
