package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.events.KeyboardEvent;
import openfl.events.Event;
import openfl.ui.Keyboard;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

class Main extends Sprite
{
private var jugador:Sprite;
private var velocidad:Int = 12;

private var izquierda:Bool = false;
private var derecha:Bool = false;

private var manzanas:Array<Manzana> = [];

private var rojasRecogidas:Int = 0;
private var rojasPerdidas:Int = 0;
private var verdesAtrapadas:Int = 0;

private var tiempoManzana:Int = 0;

private var juegoTerminado:Bool = false;
private var juegoPausado:Bool = false;

private var textoRojas:TextField;
private var textoPerdidas:TextField;
private var textoVerdes:TextField;

private var barraRojas:Sprite;
private var barraPerdidas:Sprite;
private var barraVerdes:Sprite;

private var mensaje:TextField;
private var panelMensaje:Sprite;

private var panelPausa:Sprite;
private var textoPausa:TextField;

private var musica:Sound;
private var sonidoRoja:Sound;
private var sonidoVerde:Sound;
private var sonidoCaida:Sound;
private var sonidoVictoria:Sound;
private var sonidoDerrota:Sound;

private var canalMusica:SoundChannel;


public function new()
{
    super();

    cargarSonidos();

    crearFondo();
    crearJugador();
    crearHUD();

    iniciarMusica();

    stage.addEventListener(
        KeyboardEvent.KEY_DOWN,
        teclaPresionada
    );

    stage.addEventListener(
        KeyboardEvent.KEY_UP,
        teclaSoltada
    );

    addEventListener(
        Event.ENTER_FRAME,
        actualizar
    );
}


private function cargarSonidos():Void
{
    musica = Assets.getSound(
        "assets/musica.ogg"
    );

    sonidoRoja = Assets.getSound(
        "assets/atrapar_roja.ogg"
    );

    sonidoVerde = Assets.getSound(
        "assets/atrapar_verde.ogg"
    );

    sonidoCaida = Assets.getSound(
        "assets/caida_roja.ogg"
    );

    sonidoVictoria = Assets.getSound(
        "assets/victoria.ogg"
    );

    sonidoDerrota = Assets.getSound(
        "assets/derrota.ogg"
    );
}


private function iniciarMusica():Void
{
    if (musica == null)
    {
        return;
    }

    canalMusica = musica.play(
        0,
        999
    );

    if (canalMusica != null)
    {
        canalMusica.soundTransform =
            new SoundTransform(1.0, 0);
    }
}


private function reproducirSonido(
    sonido:Sound
):Void
{
    if (sonido == null)
    {
        return;
    }

    var canal:SoundChannel =
        sonido.play(
            0,
            0
        );

    if (canal != null)
    {
        canal.soundTransform =
            new SoundTransform(1.0, 0);
    }
}


private function crearFondo():Void
{
    graphics.beginFill(0x87CEEB);

    graphics.drawRect(
        0,
        0,
        800,
        600
    );

    graphics.endFill();

    graphics.beginFill(0x72A84A);

    graphics.drawRect(
        0,
        550,
        800,
        50
    );

    graphics.endFill();

    var arbol:Bitmap = new Bitmap(
        Assets.getBitmapData(
            "assets/Arbol.png"
        )
    );

    arbol.x = 100;
    arbol.y = 40;

    arbol.width = 600;
    arbol.height = 580;

    addChild(arbol);
}


private function crearJugador():Void
{
    jugador = new Sprite();

    var canasta:Bitmap = new Bitmap(
        Assets.getBitmapData(
            "assets/Canasta.png"
        )
    );

    canasta.width = 120;
    canasta.height = 70;

    jugador.addChild(canasta);

    jugador.x = 340;
    jugador.y = 540;

    addChild(jugador);
}


private function crearHUD():Void
{
    var fondoHUD:Sprite = new Sprite();

    fondoHUD.graphics.beginFill(
        0x16251B,
        0.88
    );

    fondoHUD.graphics.drawRoundRect(
        10,
        10,
        780,
        105,
        18,
        18
    );

    fondoHUD.graphics.endFill();

    fondoHUD.graphics.beginFill(
        0xFFFFFF,
        0.12
    );

    fondoHUD.graphics.drawRoundRect(
        25,
        52,
        750,
        1,
        1,
        1
    );

    fondoHUD.graphics.endFill();

    addChild(fondoHUD);

    var titulo:TextField = new TextField();

    var formatoTitulo:TextFormat =
        new TextFormat();

    formatoTitulo.size = 20;
    formatoTitulo.bold = true;
    formatoTitulo.color = 0xFFFFFF;
    formatoTitulo.align = "center";

    titulo.defaultTextFormat =
        formatoTitulo;

    titulo.width = 780;
    titulo.height = 30;

    titulo.x = 10;
    titulo.y = 18;

    titulo.text =
        "COSECHA DE MANZANAS";

    addChild(titulo);

    crearTarjetaHUD(
        25,
        60,
        235,
        40,
        0xD94343
    );

    textoRojas = crearTextoHUD(
        45,
        64,
        190,
        24
    );

    addChild(textoRojas);

    barraRojas = crearBarra(
        45,
        91,
        190,
        6,
        0xE74C3C
    );

    addChild(barraRojas);

    crearTarjetaHUD(
        282,
        60,
        235,
        40,
        0xC77D27
    );

    textoPerdidas = crearTextoHUD(
        302,
        64,
        190,
        24
    );

    addChild(textoPerdidas);

    barraPerdidas = crearBarra(
        302,
        91,
        190,
        6,
        0xF39C12
    );

    addChild(barraPerdidas);

    crearTarjetaHUD(
        539,
        60,
        235,
        40,
        0x328C5A
    );

    textoVerdes = crearTextoHUD(
        559,
        64,
        190,
        24
    );

    addChild(textoVerdes);

    barraVerdes = crearBarra(
        559,
        91,
        190,
        6,
        0x2ECC71
    );

    addChild(barraVerdes);

    actualizarHUD();
}


private function crearTarjetaHUD(
    xPos:Float,
    yPos:Float,
    ancho:Float,
    alto:Float,
    color:Int
):Void
{
    var tarjeta:Sprite = new Sprite();

    tarjeta.graphics.beginFill(
        color,
        0.18
    );

    tarjeta.graphics.drawRoundRect(
        xPos,
        yPos,
        ancho,
        alto,
        10,
        10
    );

    tarjeta.graphics.endFill();

    addChild(tarjeta);
}


private function crearTextoHUD(
    xPos:Float,
    yPos:Float,
    ancho:Float,
    alto:Float
):TextField
{
    var texto:TextField =
        new TextField();

    var formato:TextFormat =
        new TextFormat();

    formato.size = 17;
    formato.bold = true;
    formato.color = 0xFFFFFF;
    formato.align = "center";

    texto.defaultTextFormat = formato;

    texto.width = ancho;
    texto.height = alto;

    texto.x = xPos;
    texto.y = yPos;

    return texto;
}


private function crearBarra(
    xPos:Float,
    yPos:Float,
    ancho:Float,
    alto:Float,
    color:Int
):Sprite
{
    var barra:Sprite =
        new Sprite();

    barra.graphics.beginFill(
        0x000000,
        0.35
    );

    barra.graphics.drawRoundRect(
        xPos,
        yPos,
        ancho,
        alto,
        alto,
        alto
    );

    barra.graphics.endFill();

    var progreso:Sprite =
        new Sprite();

    progreso.name = "progreso";

    progreso.graphics.beginFill(
        color,
        1
    );

    progreso.graphics.drawRoundRect(
        0,
        0,
        1,
        alto,
        alto,
        alto
    );

    progreso.graphics.endFill();

    progreso.x = xPos;
    progreso.y = yPos;

    barra.addChild(progreso);

    return barra;
}


private function actualizarHUD():Void
{
    textoRojas.text =
        "ROJAS     " +
        rojasRecogidas +
        " / 50";

    textoPerdidas.text =
        "PERDIDAS     " +
        rojasPerdidas +
        " / 3";

    textoVerdes.text =
        "VERDES     " +
        verdesAtrapadas +
        " / 3";

    actualizarBarra(
        barraRojas,
        rojasRecogidas,
        50
    );

    actualizarBarra(
        barraPerdidas,
        rojasPerdidas,
        3
    );

    actualizarBarra(
        barraVerdes,
        verdesAtrapadas,
        3
    );
}


private function actualizarBarra(
    barra:Sprite,
    actual:Int,
    maximo:Int
):Void
{
    if (barra == null)
    {
        return;
    }

    var progreso:Sprite =
        cast(
            barra.getChildByName(
                "progreso"
            ),
            Sprite
        );

    if (progreso == null)
    {
        return;
    }

    var porcentaje:Float =
        actual / maximo;

    if (porcentaje > 1)
    {
        porcentaje = 1;
    }

    if (porcentaje < 0)
    {
        porcentaje = 0;
    }

    progreso.scaleX =
        porcentaje * 190;
}


private function teclaPresionada(
    evento:KeyboardEvent
):Void
{
    if (
        evento.keyCode ==
        Keyboard.LEFT
    )
    {
        izquierda = true;
    }

    if (
        evento.keyCode ==
        Keyboard.RIGHT
    )
    {
        derecha = true;
    }

    if (
        evento.keyCode ==
        Keyboard.ESCAPE
    )
    {
        if (!juegoTerminado)
        {
            juegoPausado =
                !juegoPausado;

            actualizarPausa();
        }
    }

    if (
        evento.keyCode ==
        Keyboard.R
    )
    {
        if (juegoTerminado)
        {
            reiniciarJuego();
        }
    }
}


private function teclaSoltada(
    evento:KeyboardEvent
):Void
{
    if (
        evento.keyCode ==
        Keyboard.LEFT
    )
    {
        izquierda = false;
    }

    if (
        evento.keyCode ==
        Keyboard.RIGHT
    )
    {
        derecha = false;
    }
}


private function actualizar(
    evento:Event
):Void
{
    if (
        juegoTerminado ||
        juegoPausado
    )
    {
        return;
    }

    moverJugador();

    tiempoManzana++;

    if (tiempoManzana >= 30)
    {
        crearManzana();

        tiempoManzana = 0;
    }

    moverManzanas();
}


private function moverJugador():Void
{
    if (izquierda)
    {
        jugador.x -= velocidad;
    }

    if (derecha)
    {
        jugador.x += velocidad;
    }

    if (jugador.x < 0)
    {
        jugador.x = 0;
    }

    if (jugador.x > 680)
    {
        jugador.x = 680;
    }
}


private function crearManzana():Void
{
    var manzana:Manzana;

    if (Std.random(100) < 75)
    {
        manzana =
            new Manzana("roja");
    }
    else
    {
        manzana =
            new Manzana("verde");
    }

    manzana.x =
        150 + Std.random(500);

    manzana.y =
        100 + Std.random(100);

    addChild(manzana);

    manzanas.push(manzana);
}


private function moverManzanas():Void
{
    var i:Int =
        manzanas.length - 1;

    while (i >= 0)
    {
        var manzana:Manzana =
            manzanas[i];

        manzana.y +=
            manzana.velocidad;

        if (colisionCanasta(manzana))
        {
            if (
                manzana.tipo ==
                "roja"
            )
            {
                rojasRecogidas++;

                reproducirSonido(
                    sonidoRoja
                );

                if (
                    rojasRecogidas >=
                    50
                )
                {
                    ganarJuego();
                }
            }
            else
            {
                verdesAtrapadas++;

                reproducirSonido(
                    sonidoVerde
                );

                if (
                    verdesAtrapadas >=
                    3
                )
                {
                    perderJuego(
                        "Atrapaste 3 manzanas verdes"
                    );
                }
            }

            removeChild(manzana);

            manzanas.splice(
                i,
                1
            );

            actualizarHUD();

            i--;

            continue;
        }

        if (manzana.y > 550)
        {
            if (
                manzana.tipo ==
                "roja"
            )
            {
                rojasPerdidas++;

                reproducirSonido(
                    sonidoCaida
                );

                if (
                    rojasPerdidas >=
                    3
                )
                {
                    perderJuego(
                        "Se cayeron 3 manzanas rojas"
                    );
                }
            }

            removeChild(manzana);

            manzanas.splice(
                i,
                1
            );

            actualizarHUD();
        }

        i--;
    }
}


private function colisionCanasta(
    manzana:Manzana
):Bool
{
    var izquierdaCanasta:Float =
        jugador.x + 20;

    var derechaCanasta:Float =
        jugador.x + 100;

    var arribaCanasta:Float =
        jugador.y + 10;

    var mitadManzana:Float =
        27.5;

    var izquierdaManzana:Float =
        manzana.x -
        mitadManzana;

    var derechaManzana:Float =
        manzana.x +
        mitadManzana;

    var parteInferiorManzana:Float =
        manzana.y +
        mitadManzana;

    var colisionHorizontal:Bool =
        derechaManzana >=
            izquierdaCanasta &&
        izquierdaManzana <=
            derechaCanasta;

    var colisionVertical:Bool =
        parteInferiorManzana >=
            arribaCanasta;

    return
        colisionHorizontal &&
        colisionVertical;
}


private function ganarJuego():Void
{
    juegoTerminado = true;

    reproducirSonido(
        sonidoVictoria
    );

    mostrarMensaje(
        "¡GANASTE!\n\n" +
        "Conseguiste 50 manzanas rojas\n\n" +
        "Presiona R para volver a jugar"
    );
}


private function perderJuego(
    razon:String
):Void
{
    juegoTerminado = true;

    reproducirSonido(
        sonidoDerrota
    );

    mostrarMensaje(
        "¡PERDISTE!\n\n" +
        razon +
        "\n\n" +
        "Presiona R para volver a jugar"
    );
}


private function mostrarMensaje(
    texto:String
):Void
{
    panelMensaje =
        new Sprite();

    panelMensaje.graphics.beginFill(
        0x18251D,
        0.97
    );

    panelMensaje.graphics.drawRoundRect(
        100,
        165,
        600,
        270,
        25,
        25
    );

    panelMensaje.graphics.endFill();

    panelMensaje.graphics.lineStyle(
        3,
        0xFFFFFF,
        0.15
    );

    panelMensaje.graphics.drawRoundRect(
        100,
        165,
        600,
        270,
        25,
        25
    );

    addChild(panelMensaje);

    mensaje =
        new TextField();

    var formato:TextFormat =
        new TextFormat();

    formato.size = 28;
    formato.bold = true;
    formato.color = 0xFFFFFF;
    formato.align = "center";

    mensaje.defaultTextFormat =
        formato;

    mensaje.width = 560;
    mensaje.height = 220;

    mensaje.x = 120;
    mensaje.y = 195;

    mensaje.text = texto;

    addChild(mensaje);
}


private function actualizarPausa():Void
{
    if (juegoPausado)
    {
        if (panelPausa == null)
        {
            panelPausa =
                new Sprite();

            panelPausa.graphics.beginFill(
                0x000000,
                0.55
            );

            panelPausa.graphics.drawRect(
                0,
                0,
                800,
                600
            );

            panelPausa.graphics.endFill();

            addChild(panelPausa);

            textoPausa =
                new TextField();

            var formato:TextFormat =
                new TextFormat();

            formato.size = 42;
            formato.bold = true;
            formato.color = 0xFFFFFF;
            formato.align = "center";

            textoPausa.defaultTextFormat =
                formato;

            textoPausa.width = 800;
            textoPausa.height = 120;

            textoPausa.x = 0;
            textoPausa.y = 240;

            textoPausa.text =
                "PAUSA\n\nESC para continuar";

            addChild(textoPausa);
        }

        panelPausa.visible = true;
        textoPausa.visible = true;
    }
    else
    {
        if (panelPausa != null)
        {
            panelPausa.visible = false;
        }

        if (textoPausa != null)
        {
            textoPausa.visible = false;
        }
    }
}


private function reiniciarJuego():Void
{
    for (manzana in manzanas)
    {
        if (contains(manzana))
        {
            removeChild(manzana);
        }
    }

    manzanas = [];

    rojasRecogidas = 0;
    rojasPerdidas = 0;
    verdesAtrapadas = 0;

    jugador.x = 340;

    tiempoManzana = 0;

    juegoTerminado = false;
    juegoPausado = false;

    if (
        mensaje != null &&
        contains(mensaje)
    )
    {
        removeChild(mensaje);

        mensaje = null;
    }

    if (
        panelMensaje != null &&
        contains(panelMensaje)
    )
    {
        removeChild(
            panelMensaje
        );

        panelMensaje = null;
    }

    if (panelPausa != null)
    {
        panelPausa.visible =
            false;
    }

    if (textoPausa != null)
    {
        textoPausa.visible =
            false;
    }

    actualizarHUD();
}

}

class Manzana extends Sprite
{
public var tipo:String;
public var velocidad:Float;

public function new(
    tipoManzana:String
)
{
    super();

    tipo =
        tipoManzana;

    velocidad =
        3 + Std.random(5);

    var imagen:Bitmap;

    if (tipo == "roja")
    {
        imagen =
            new Bitmap(
                Assets.getBitmapData(
                    "assets/Manzana Roja.png"
                )
            );
    }
    else
    {
        imagen =
            new Bitmap(
                Assets.getBitmapData(
                    "assets/Manzana Verde.png"
                )
            );
    }

    imagen.width = 55;
    imagen.height = 55;

    imagen.x = -22;
    imagen.y = -22;

    addChild(imagen);
}

}
