from django import forms
#from django.forms import  ModelForm
from web.models import *

class Form(forms.ModelForm):
    class Meta:
        model = Article
        #fields=['name', 'title', 'contents', 'url', 'email']
        fields=['name']

        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
        }

 #       widgets = {
  #          'name': ModelForm.CharField(attrs={'placeholder': 'Name'}),
      #      'name': ModelForm.Textarea(
       #         attrs={'placeholder': 'Enter description here'}),
#        }

   #      def __init__(self, user, *args, **kwargs):
  #          super(Form, self).__init__(user, *args, **kwargs)
 #           for field in self.fields:
#                self.fields[field].widget.attrs['class'] = 'form-control'