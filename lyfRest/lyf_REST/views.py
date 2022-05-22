# import pyrebase as pb


# config = {
#     "apiKey": "AIzaSyD91ItGd0HT83Q38I8AWi-OwlK9l_gP17I",
#     "authDomain": "thelyfapp-971b5.firebaseapp.com",
#     "projectId": "thelyfapp-971b5",
#     "storageBucket": "thelyfapp-971b5.appspot.com",
#     "messagingSenderId": "965674940805",
#     "appId": "1:965674940805:web:aa9139f61379ba3cad2cec",
#     "measurementId": "G-MTPXNGX7EZ",
# }

# firebase = pb.initialize_app(config)
from django.conf import settings
from django.shortcuts import render


def index(request):
    return render(request,str(settings.BASE_DIR)+"/static/templates/index.html")

def handler500(request,*args, **argv):
    response = render(request,str(settings.BASE_DIR)+"/static/templates/500.html" )
    response.status_code=500
    return response

def handler404(request,exception):
    response = render(request,str(settings.BASE_DIR)+"/static/templates/404.html" )
    print(response.status_code)
    print(exception)
    response.status_code=404
    return response
