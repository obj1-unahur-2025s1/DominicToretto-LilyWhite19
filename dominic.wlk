object dominic{
    const autos = []

    method autos() = autos
    method comprar(unAuto) = autos.add(unAuto)
    method peso() = 70
    method autosNoEnCondiciones() = autos.filter({a => !a.estaEnCondiciones()})
    method autosEnCondiciones() = autos.filter({a => a.estaEnCondiciones()})
    method mandarAutosAlTaller() {
        taller.recibirAutos(self.autosNoEnCondiciones())
    }
    method trabajarEnElTaller(){
        taller.repararAutos()
    }
    method pruebasDeVelocidad(){
        autos.forEach({a => a.hacerPrueba()})
    }
    method venderAutos(){
        autos.clear()
    }
    method promedioVelocidades(){
        return autos.sum({a => a.velocidadMaxima()}) / autos.size()
    }
    method autoMasRapidoEnCondiciones(){
        return self.autosEnCondiciones().max({a => a.velocidadMaxima()})
    }
    method hayUnAutoMuyRapido(){
        return self.autoMasRapidoEnCondiciones().velocidadMaxima() >
        2 * self.promedioVelocidades()
    }
}

object taller{
    const autosAReparar = []
    method autosAReparar() = autosAReparar
    method recibirAutos(unaListaDeAutos) {
        autosAReparar.addAll(unaListaDeAutos)
    }
    method repararAutos(){
        autosAReparar.forEach({a => a.reparar()})
        autosAReparar.clear()
    }
}

object ferrari{
    var motor = 87
    method velocidadMaxima() = 110 + if (motor > 75) 15 else 0
    method estaEnCondiciones() = motor >= 65
    method reparar() {motor = 100}
    method hacerPrueba() {
        motor = (motor - 30).max(0)
    }
}

object flechaRubi{
    var cantidadCombustible = 100
    var property combustible = gasolina
    var color = azul
    method estaEnCondiciones() =
        cantidadCombustible > combustible.nivelMinimo() && color.aptoParaCorrer()  
    method reparar(){
        cantidadCombustible = cantidadCombustible * 2
        color = color.cambiarDeColor()
    }
    method hacerPrueba(){
        cantidadCombustible = (cantidadCombustible - 5).max(0)
    }
    method velocidadMaxima(){
        return combustible.velociadadMaxima()
    }
    method velocidadBase() = cantidadCombustible * 2
}

object gasolina{
    method nivelMinimo() = 85
    method velociadadMaxima() = 
        flechaRubi.velocidadBase() + 10
}
object nafta{
    method nivelMinimo() = 50
    method velociadadMaxima() = 
        (flechaRubi.velocidadBase()) - ((flechaRubi.velocidadBase()) / 10)
}
object nitrogenoLiquido{
    method nivelMinimo() = 0
    method velociadadMaxima() = 
        (flechaRubi.velocidadBase()) * 10
}
object rojo {
    method cambiarDeColor() = azul
    method aptoParaCorrer() = true
}
object azul{
    method cambiarDeColor() = verde
    method aptoParaCorrer() = false
}
object verde{
    method cambiarDeColor() = rojo
    method aptoParaCorrer() = false
}

object intocable{
    var property estaEnCondiciones = true
    method hacerPrueba() {
        estaEnCondiciones = false
    }
    method reparar() {
        estaEnCondiciones = true
    }
    method velocidadMaxima() = 45
}

object inventado{
    var peso = 150 + dominic.peso() + copiloto.peso()
    var property copiloto = mark
    method estaEnCondiciones() = copiloto.esAptoParaCorrer() && peso <= 350
    method velocidadMaxima() = 120 + if(peso.between(200, 300)) 15 else 0
    method reparar(){
        peso = (peso - 50).max(100 + dominic.peso() + copiloto.peso())
    }
    method hacerPrueba(){
        peso = (peso + 10).min(400)
    }
}

object mark{
    method peso() = 65
    method esAptoParaCorrer() = true
}
object leo{
    method peso() = 90
    method esAptoParaCorrer() = false
}
object iara{
    method peso() = 50
    method esAptoParaCorrer() = true
}