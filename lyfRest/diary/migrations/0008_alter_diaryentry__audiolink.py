# Generated by Django 4.0.2 on 2022-02-18 17:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('diary', '0007_alter_diaryentry__imagelinks'),
    ]

    operations = [
        migrations.AlterField(
            model_name='diaryentry',
            name='_audioLink',
            field=models.TextField(blank=True, null=True, verbose_name='audioFileLink'),
        ),
    ]