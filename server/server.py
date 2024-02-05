from fastapi import FastAPI
from server.constants import *
from server.core.api_models import DeliveryBroker_API, InvoiceItem_API, OrderMed_API, Payment_API, Product_API, User_API
from server.features.product.product_fetch import fetch_all_product, fetch_product_by_id
from server.features.product.product_insert import insert_product

# ----------- App initialisation -------------------------------------

app = FastAPI()

# ------------- Standard endpoints -----------------------------------------------

@app.get("/")
def home():
    return {'data': 'Hello from the other side'}

# # DeliveryBroker related endpoints

# @app.get("/DeliveryBroker/all")
# def get_all_DeliveryBrokers():
#     return fetch_all_type_DeliveryBroker()

# @app.get("/DeliveryBroker/{DeliveryBroker_id}")
# def get_DeliveryBroker_by_id(DeliveryBroker_id: str):
#     res = fetch_DeliveryBroker_by_id(DeliveryBroker_id)
#     return res

# @app.post("/DeliveryBroker/insertion")
# def insert_DeliveryBroker(DeliveryBroker: DeliveryBroker_API):
#     res = insert_DeliveryBroker(DeliveryBroker)
#     return res

# # DeliveryPromotion related endpoints

# @app.get("/DeliveryPromotion/all")
# def get_all_DeliveryPromotions():
#     return fetch_all_type_DeliveryPromotion()

# @app.get("/DeliveryPromotion/{DeliveryPromotion_id}")
# def get_DeliveryPromotion_by_id(DeliveryPromotion_id: str):
#     res = fetch_DeliveryPromotion_by_id(DeliveryPromotion_id)
#     return res

# @app.post("/DeliveryPromotion/insertion")
# def insert_DeliveryBroker(DeliveryPromotion: DeliveryBroker_API):
#     res = insert_DeliveryPromotion(DeliveryPromotion)
#     return res

# # Order related endpoints

# @app.get("/Order/all")
# def get_all_OrderMeds():
#     return fetch_all_type_Order()

# @app.get("/Order/{Order_id}")
# def get_Order_by_id(Order_id: str):
#     res = fetch_Order_by_id(Order_id)
#     return res

# @app.post("/Order/insertion")
# def insert_Order(Order: OrderMed_API):
#     res = insert_Order(Order)
#     return res

# Product related endpoints

@app.get("/Product/all")
def get_all_Products():
    return fetch_all_product()

@app.get("/Product/{Product_id}")
def get_Product_by_id(Product_id: str):
    res = fetch_product_by_id(Product_id)
    return res

@app.post("/Product/insertion")
def insert_Product(product: Product_API):
    res = insert_product(product)
    return res

# # User related endpoints

# @app.get("/User/all")
# def get_all_Users():
#     return fetch_all_type_User()

# @app.get("/User/{User_id}")
# def get_User_by_id(User_id: str):
#     res = fetch_User_by_id(User_id)
#     return res

# @app.post("/User/insertion")
# def insert_User(User: User_API):
#     res = insert_User(User)
#     return res

# # Payment related endpoints

# @app.get("/Payment/all")
# def get_all_Payments():
#     return fetch_all_type_Payment()

# @app.get("/Payment/{Payment_id}")
# def get_Payment_by_id(Payment_id: str):
#     res = fetch_Payment_by_id(Payment_id)
#     return res

# @app.post("/Payment/insertion")
# def insert_Payment(Payment: Payment_API):
#     res = insert_Payment(Payment)
#     return res

# # InvoiceItem related endpoints

# @app.get("/InvoiceItem/all")
# def get_all_InvoiceItems():
#     return fetch_all_type_InvoiceItem()

# @app.get("/InvoiceItem/{InvoiceItem_id}")
# def get_InvoiceItem_by_id(InvoiceItem_id: str):
#     res = fetch_InvoiceItem_by_id(InvoiceItem_id)
#     return res

# @app.post("/InvoiceItem/insertion")
# def insert_InvoiceItem(InvoiceItem: InvoiceItem_API):
#     res = insert_InvoiceItem(InvoiceItem)
#     return res


# # Invoice related endpoints

# @app.get("/Invoice/all")
# def get_all_Invoices():
#     return fetch_all_type_Invoice()

# @app.get("/Invoice/{Invoice_id}")
# def get_Invoice_by_id(Invoice_id: str):
#     res = fetch_Invoice_by_id(Invoice_id)
#     return res

# @app.post("/Invoice/insertion")
# def insert_Invoice(Invoice: Invoice_API):
#     res = insert_Invoice(Invoice)
#     return res