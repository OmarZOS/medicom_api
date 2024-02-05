import mysql.connector

def test_mysql_connection(host, user, password, database):
    try:
        # Establish a connection to the MySQL server
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )

        # Check if the connection is successful
        if connection.is_connected():
            print("Connected to MySQL database")
            
            # Perform additional operations if needed

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        # Close the connection, whether successful or not
        if 'connection' in locals() and connection.is_connected():
            connection.close()
            print("Connection closed")

# Replace these values with your MySQL server details
host = "localhost"
user = "dev_user"
password = "dev_password"
database = "Medicom"

# Test the MySQL connection
test_mysql_connection(host, user, password, database)

