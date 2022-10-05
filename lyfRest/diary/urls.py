from django.urls import path
from . import views

urlpatterns = [
    path('', views.getAllDiaries),
    path('pdf/', views.getAllPDFs),
    path('txt/', views.getAllTXTs),
    path('create/', views.createEntry),
    path('<str:entryId>/', views.getEntrybyId),
    path('<str:entryId>/update/', views.updateEntry),
    path('<str:entryId>/delete/', views.deleteEntry),
    path('<str:entryId>/<str:entryId2>.pdf', views.getPDFbyEntryId),
    path('<str:entryId>/<str:entryId2>.txt', views.getTXTbyEntryId),
]