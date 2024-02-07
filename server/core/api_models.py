from sqlalchemy.orm import declarative_base
from typing import List
from pydantic import BaseModel

Base = declarative_base()
metadata = Base.metadata

class DeliveryBroker_API(BaseModel):
    brokerId: int
    brokerName: str
    
class DeliveryPromotion_API(BaseModel):
    promotionId: int
    productsupplierId: int
    deliverybrokerId: int
    discount: float
    statusId: int
    status: str
    timestamp: str


class OrderMed_API(BaseModel):
    order_MedId: int
    paymentMethod: str
    order_Medstatus: str
    order_timestamp: str
    reviewId: int
    user_MedId: int
    productId: int
    rating: int
    comment: str
    review_timestamp: str

class Product_API(BaseModel):
    productId: int
    productName: str
    description: str
    price: float
    availability: int
    categoryId: int
    categoryName: str
    category_description: str
    supplierId: int
    supplierName: str

class User_API(BaseModel):
    user_MedId: int
    user_Medname: str
    email: str
    password: str
    fullName: str
    address: str
    preferences_id: int
    user_preferences: List[str]
    user_RoleId : int
    user_role: str

class Payment_API(BaseModel):
    paymentId: int
    order_MedId: int
    paymentMethod: str
    amount: float
    paymentstatus: str
    timestamp: str
    methodId: int
    methodName: str

class InvoiceItem_API(BaseModel):
    quantity: int
    unitPrice: float
    subtotal: float

class Invoice_API(BaseModel):
    order_MedId: int
    totalAmount: float
    issueDate: str
    invoiceId: int