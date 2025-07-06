<?php

use App\Http\Controllers\api\SlashCommandController;
use Illuminate\Support\Facades\Route;

Route::get('/test', function () {
    return 'api route ok';
});


Route::post('/slash-command', [SlashCommandController::class, 'index'])
    ->name('api.slash-command.index');
