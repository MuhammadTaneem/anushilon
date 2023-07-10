from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import AllowAny
from django.contrib.auth import authenticate, login


class CustomLoginView(APIView):
    authentication_classes = [BasicAuthentication]
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            email = request.data.get('email')
            password = request.data.get('password')

            if not email or not password:
                return Response({'message': 'Email and password are required.'}, status=status.HTTP_400_BAD_REQUEST)

            user = authenticate(request, email=email, password=password)

            if user:
                login(request, user)
                token, created = Token.objects.get_or_create(user=user)
                response_data = {
                    'message': 'Login successful',
                    'id': user.id,
                    'email': user.email,
                    'role': user.role,
                    'token': token.key
                }
                return Response(response_data, status=status.HTTP_200_OK)
            else:
                return Response({'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

        except Exception as e:
            return Response({'message': 'Internal server error.', 'error': str(e)},
                            status=status.HTTP_500_INTERNAL_SERVER_ERROR)
