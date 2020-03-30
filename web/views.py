from django.shortcuts import render, redirect
from web.forms import *
from gspreadAPI.gspread import *

def write(request):
    if request.method == 'POST':
        form = Form(request.POST)
        if form.is_valid():
            form.save()
            #print(form.data.get('name'))
            name = form.data.get('name')
            writeCell(name)
            return redirect('list')
    form = Form()

    return render(request, 'write.html', {'form' : form})

def list(request):
    articleList = Article.objects.all()
    return render(request, 'list.html', {'articleList':articleList})

def view(request, num="1"):
    article = Article.objects.get(id=num)
    return render(request, 'view.html', {'article':article, 'Test':readCell()})

# Create your views here.
