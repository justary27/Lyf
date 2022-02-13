from django.urls import path
from . import views

urlpatterns = [
    path('',views.getAllDiaries),
    path('pdfs/', views.getAllPDFs),
    path('create/', views.createEntry),
    path('<str:entryId>/', views.getEntrybyId),
    path('<str:entryId>/update/', views.updateEntry),
    path('<str:entryId>/delete/', views.deleteEntry),
    path('<str:entryId>/pdf/', views.getPDFbyEntryId),

]