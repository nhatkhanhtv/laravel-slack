<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class SlashCommandController extends Controller
{
    public function index(Request $request)
    {
        return $request->all();
    }
}
