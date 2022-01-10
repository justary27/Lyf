from rest_framework import serializers
from .models import Todo

# create your serializers here

class TodoSerializer(serializers.ModelSerializer):
    
    class Meta:

        model = Todo
        fields = "__all__"