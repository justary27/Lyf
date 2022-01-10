from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.authtoken.models import Token          
from .models import LyfUser
from rest_framework import status
from rest_framework.authtoken.views import ObtainAuthToken
# Create your views here.

@api_view(["GET",])
@permission_classes([IsAuthenticated])
def get(request, userId):
    try:
        user = LyfUser.objects.get_user_by_id(userId)
        data = user.asDict
        return Response(data)
        
    except Exception as e:
        return Response(str(e), status=status.HTTP_401_UNAUTHORIZED)

@api_view(["POST"])
def createAccount(request):
    data = request.data

    try:
        entry = LyfUser.objects.create_user(
            email = data['email'],
            username = data['username'],
            password = data['password'],
            )
        user = LyfUser.objects.get(
            email = data['email'] )
        token = Token.objects.get(user = user)
        return Response(
            {
                'userId': user._id,
                'token':str(token),
                'isActive':str(user.is_active),
            }
        )

    except Exception as e:
        print(e)
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST)

# @api_view(["POST"])
# def loginToAccount(request):
#     data = request.data

#     try:
        
#         user = LyfUser.objects.login_user(
#             email = data['email'], 
#             password = data['password'],
#             )
#         token = Token.objects.get(user = user)
#         return Response(
#             {
#                 'userId': user._id,
#                 'token':str(token),
#                 'isActive':str(user.is_active),
#             }
#         )
#     except Exception as e:
#         return Response(str(e),status=status.HTTP_401_UNAUTHORIZED)


class loginToAccount(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        if serializer.is_valid():
            user = serializer.validated_data['user']
            token = Token.objects.get(user=user)
            return Response({
                    'userId': user._id,
                    'token':str(token),
                    'isActive':str(user.is_active),
            })
            
        else:
            return Response(str(serializer.errors),status=status.HTTP_401_UNAUTHORIZED)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def updateAccount(request, userId):
    data = request.data

    try:
        entry = LyfUser.objects.update(
            email = data['email'],
            username = data['username'],
            )
    except Exception as e:
        return Response(str(e), status = status.HTTP_401_UNAUTHORIZED)

@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def deactivateAccount(request,userId):
    user = LyfUser.objects.get_user_by_id(userId)    
    
    try:
        user.delete()
        return Response("Account deactivated successfully!")

    except Exception as e:
        return Response(str(e),status=status.HTTP_401_UNAUTHORIZED)

@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def deleteAccount(request,userId):
    user = LyfUser.objects.get_user_by_id(userId)    
    
    try:
        user.delete()
        return Response("Account deleted successfully!")

    except Exception as e:
        return Response(str(e),status=status.HTTP_401_UNAUTHORIZED)
