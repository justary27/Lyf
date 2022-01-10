from rest_framework import serializers
from .models import DiaryEntry

# create your serializers here

class DiaryEntrySerializer(serializers.ModelSerializer):
    
    class Meta:

        model = DiaryEntry
        fields = "__all__"