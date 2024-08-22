from application import create_app

import pytest
import random


class TestApplication():
    # This function has been created by chatGPT
    # If you want to debug complain with it
    def generate_cpf(self):
        # Generate the first 9 random digits
        cpf = [random.randint(0, 9) for _ in range(9)]

        # Calculate the first verification digit
        sum_first = sum((cpf[i] * (10 - i) for i in range(9)))
        first_verification_digit = (sum_first * 10 % 11) % 10
        cpf.append(first_verification_digit)

        # Calculate the second verification digit
        sum_second = sum((cpf[i] * (11 - i) for i in range(10)))
        second_verification_digit = (sum_second * 10 % 11) % 10
        cpf.append(second_verification_digit)

        # Convert list of digits into a formatted string
        cpf_str = ''.join(map(str, cpf))
        formatted_cpf = f'{cpf_str[:3]}.{cpf_str[3:6]}.{cpf_str[6:9]}-' \
                        f'{cpf_str[9:]}'

        return formatted_cpf

    @pytest.fixture()
    def client(self):
        app = create_app("config.MockConfig")
        return app.test_client()

    @pytest.fixture()
    def valid_user(self):
        return {
            "first_name": "Teste",
            "last_name": "Rachador",
            "email": "rachador@teste.com",
            "birth_date": "1971-10-10"
        }

    def test_get_users_success(self, client):
        response = client.get("/users")
        assert response.status_code == 200

    def test_post_user_success(self, client, valid_user):
        complete_user = {
            **valid_user,
            "cpf": self.generate_cpf()
        }
        response = client.post("/user", json=complete_user)
        assert response.status_code == 201

    def test_post_user_fail_validate_cpf(self, client, valid_user):
        invalid_user = {
            **valid_user,
            "cpf": "invalid"
        }
        response = client.post("/user", json=invalid_user)
        assert response.status_code == 400

    def test_post_user_fail_cpf_already_exists(self, client, valid_user):
        cpf_preallocated_user = {
            **valid_user, "cpf": "123.456.789-09"
        }
        client.post("/user", json=cpf_preallocated_user)
        response = client.post("/user", json=cpf_preallocated_user)
        assert response.status_code == 412

    def test_get_user_success(self, client, valid_user):
        cpf_preallocated_user = {
            **valid_user, "cpf": "123.456.789-09"
        }
        response = client.get("/user/%s" % cpf_preallocated_user["cpf"])
        assert response.status_code == 200

    def test_get_user_fail_user_not_found(self, client, valid_user):
        complete_user = {
            **valid_user,
            "cpf": self.generate_cpf()
        }
        response = client.get("/user/%s" % complete_user["cpf"])
        assert response.status_code == 404
