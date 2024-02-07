

from server.core.models import UserMed, UserMedPreferences, UserMedRole
import server.storage.storage_broker as storage_broker

def fetch_all_users():
    return storage_broker.get(UserMed)

def fetch_user_by_id(user_id: int):
    return storage_broker.get(UserMed,{UserMed.user_MedId:user_id},[UserMedRole,UserMedPreferences])





    