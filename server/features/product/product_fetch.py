
from server.core.models import Product, ProductSupplier
import server.storage.storage_broker as storage_broker

def fetch_product_by_id(prod_id: str):
    return storage_broker.get(Product,{Product.productId:prod_id},[ProductSupplier])

def fetch_all_product():
    return storage_broker.get(Product)


    