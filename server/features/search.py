
from server.features.search_methods.tf_idf_search import add_many_tokens, add_single_token


def add_tokens(search_key,tokens:list):
    add_many_tokens(search_key, tokens)


def add_token(search_key,token):
    add_single_token(search_key, token)










