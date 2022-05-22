"""lyf_REST URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.urls.conf import include
from . import views
from User import views as userViews

handler500 = 'lyf_REST.views.handler500'
handler404 = 'lyf_REST.views.handler404'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index),
    path('signUp/', userViews.createAccount),
    path('verify/<str:userId>/', userViews.verificationEmail),
    path('verifyAccount/<str:userId>', userViews.verifyAccount),
    path('logIn/', userViews.loginToAccount.as_view()),
    path("<str:userId>/", include("User.urls")),
]
