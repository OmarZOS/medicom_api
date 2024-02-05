from sqlalchemy import Column, DateTime, Double, ForeignKeyConstraint, Index, Integer, JSON, String, Table, Text
from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()
metadata = Base.metadata


class Category(Base):
    __tablename__ = 'Category'

    categoryId = Column(Integer, primary_key=True)
    categoryName = Column(String(255))
    description = Column(Text)

    Product = relationship('Product', secondary='CategoryBelonging', back_populates='Category_')


class DeliveryBroker(Base):
    __tablename__ = 'DeliveryBroker'

    brokerId = Column(Integer, primary_key=True)
    brokerName = Column(String(255))

    Promotion = relationship('Promotion', back_populates='DeliveryBroker_')


class DeliveryStatus(Base):
    __tablename__ = 'DeliveryStatus'

    statusId = Column(Integer, primary_key=True)
    status = Column(String(255))
    timestamp = Column(DateTime)


class InvoiceItem(Base):
    __tablename__ = 'InvoiceItem'

    quantity = Column(Integer, primary_key=True, nullable=False)
    unitPrice  = Column(Double(asdecimal=True), primary_key=True, nullable=False)
    subtotal = Column(Double(asdecimal=True), primary_key=True, nullable=False)


class OrderMed(Base):
    __tablename__ = 'Order_Med'

    order_MedId = Column(Integer, primary_key=True)
    cartId = Column(Integer)
    paymentMethod = Column(String(255))
    order_Medstatus = Column(String(255))
    timestamp = Column(DateTime)

    Invoice = relationship('Invoice', back_populates='Order_Med')
    Payment = relationship('Payment', back_populates='Order_Med')


class PaymentMethod(Base):
    __tablename__ = 'PaymentMethod'

    methodId = Column(Integer, primary_key=True)
    methodName = Column(String(255))


class Product(Base):
    __tablename__ = 'Product'

    productId = Column(Integer, primary_key=True)
    productName = Column(String(255))
    description = Column(Text)
    price = Column(Double(asdecimal=True))
    availability = Column(Integer)

    Category_ = relationship('Category', secondary='CategoryBelonging', back_populates='Product')
    ProductSupplier = relationship('ProductSupplier', secondary='SupplyInfo', back_populates='Product_')
    Review = relationship('Review', back_populates='Product_')


class ProductSupplier(Base):
    __tablename__ = 'ProductSupplier'

    supplierId = Column(Integer, primary_key=True)
    supplierName = Column(String(255))

    Product_ = relationship('Product', secondary='SupplyInfo', back_populates='ProductSupplier')
    Promotion = relationship('Promotion', back_populates='ProductSupplier_')


class UserMed(Base):
    __tablename__ = 'User_Med'

    user_MedId = Column(Integer, primary_key=True)
    user_Medname = Column(String(255))
    email = Column(String(255))
    password = Column(String(255))

    Review = relationship('Review', back_populates='User_Med')


class UserMedPreferences(Base):
    __tablename__ = 'User_MedPreferences'

    user_MedId = Column(Integer, primary_key=True)
    preferences = Column(JSON)


class UserMedProfile(Base):
    __tablename__ = 'User_MedProfile'

    user_MedId = Column(Integer, primary_key=True)
    fullName = Column(String(255))
    address = Column(String(255))


class UserMedRole(Base):
    __tablename__ = 'User_MedRole'

    user_MedId = Column(Integer, primary_key=True)
    role = Column(String(255))


t_CategoryBelonging = Table(
    'CategoryBelonging', metadata,
    Column('productId', Integer, primary_key=True, nullable=False),
    Column('categoryId', Integer, primary_key=True, nullable=False),
    ForeignKeyConstraint(['categoryId'], ['Category.categoryId'], name='CategoryBelonging_ibfk_2'),
    ForeignKeyConstraint(['productId'], ['Product.productId'], name='CategoryBelonging_ibfk_1'),
    Index('categoryId', 'categoryId')
)


class Invoice(Base):
    __tablename__ = 'Invoice'
    __table_args__ = (
        ForeignKeyConstraint(['order_MedId'], ['Order_Med.order_MedId'], name='Invoice_ibfk_1'),
        Index('order_MedId', 'order_MedId')
    )

    invoiceId = Column(Integer, primary_key=True)
    order_MedId = Column(Integer)
    totalAmount = Column(Double(asdecimal=True))
    issueDate = Column(DateTime)

    Order_Med = relationship('OrderMed', back_populates='Invoice')


class Payment(Base):
    __tablename__ = 'Payment'
    __table_args__ = (
        ForeignKeyConstraint(['order_MedId'], ['Order_Med.order_MedId'], name='Payment_ibfk_1'),
        Index('order_MedId', 'order_MedId')
    )

    paymentId = Column(Integer, primary_key=True)
    order_MedId = Column(Integer)
    paymentMethod = Column(String(255))
    amount = Column(Double(asdecimal=True))
    paymentstatus = Column(String(255))
    timestamp = Column(DateTime)

    Order_Med = relationship('OrderMed', back_populates='Payment')


class Promotion(Base):
    __tablename__ = 'Promotion'
    __table_args__ = (
        ForeignKeyConstraint(['deliverybrokerId'], ['DeliveryBroker.brokerId'], name='Promotion_ibfk_2'),
        ForeignKeyConstraint(['productsupplierId'], ['ProductSupplier.supplierId'], name='Promotion_ibfk_1'),
        Index('deliverybrokerId', 'deliverybrokerId'),
        Index('productsupplierId', 'productsupplierId')
    )

    promotionId = Column(Integer, primary_key=True)
    productsupplierId = Column(Integer)
    deliverybrokerId = Column(Integer)
    discount = Column(Double(asdecimal=True))

    DeliveryBroker_ = relationship('DeliveryBroker', back_populates='Promotion')
    ProductSupplier_ = relationship('ProductSupplier', back_populates='Promotion')


class Review(Base):
    __tablename__ = 'Review'
    __table_args__ = (
        ForeignKeyConstraint(['productId'], ['Product.productId'], name='Review_ibfk_2'),
        ForeignKeyConstraint(['user_MedId'], ['User_Med.user_MedId'], name='Review_ibfk_1'),
        Index('productId', 'productId'),
        Index('user_MedId', 'user_MedId')
    )

    reviewId = Column(Integer, primary_key=True)
    user_MedId = Column(Integer)
    productId = Column(Integer)
    rating = Column(Integer)
    comment = Column(Text)
    timestamp = Column(DateTime)

    Product_ = relationship('Product', back_populates='Review')
    User_Med = relationship('UserMed', back_populates='Review')


t_SupplyInfo = Table(
    'SupplyInfo', metadata,
    Column('supplierId', Integer, primary_key=True, nullable=False),
    Column('productId', Integer, primary_key=True, nullable=False),
    ForeignKeyConstraint(['productId'], ['Product.productId'], name='SupplyInfo_ibfk_2'),
    ForeignKeyConstraint(['supplierId'], ['ProductSupplier.supplierId'], name='SupplyInfo_ibfk_1'),
    Index('productId', 'productId')
)
