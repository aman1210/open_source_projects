package com.example.kotlin_calculator

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.example.kotlin_calculator.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    var lastNumeric = false
    var lastDot = false


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setContentView(R.layout.activity_main)
    }

    fun onDigit(view: View){
        setContentView(binding.root)
        binding.calDisplay.append((view as Button).text)
        lastNumeric = true
    }

    fun onCLR(view: View){
        setContentView(binding.root)
        binding.calDisplay.text = ""
        lastNumeric = false
        lastDot = false
    }

    fun onDecimal(view: View){
        if(lastNumeric && !lastDot){
            setContentView(binding.root)
            binding.calDisplay.append(".")
            lastNumeric = false
            lastDot = true
        }
    }

    fun onOperator(view: View){
        setContentView(binding.root)
        if(lastNumeric && !isOperatorAdded(binding.calDisplay.text.toString())){
            binding.calDisplay.append((view as Button).text)
            lastNumeric = false
            lastDot = false
        }
    }

    fun onEqual(view: View){
        setContentView((binding.root))
        if (lastNumeric){
            var textViewValue = binding.calDisplay.text.toString()
            var prefix=""
            try {
                if(textViewValue.startsWith("-")){
                    prefix="-"
                    textViewValue = textViewValue.substring(1)
                }
                if(textViewValue.contains("-")){
                    var splitValue = textViewValue.split("-")
                    var left = prefix + splitValue[0]
                    var right = splitValue[1]

                    binding.calDisplay.text = removeExtraZero((left.toDouble()-right.toDouble()).toString())
                }
                else if(textViewValue.contains("x")){
                    var splitValue = textViewValue.split("x")
                    var left = prefix + splitValue[0]
                    var right = splitValue[1]

                    binding.calDisplay.text = removeExtraZero(left.toDouble().times(right.toDouble()).toString())
                }
                else if(textViewValue.contains("+")){
                    var splitValue = textViewValue.split("+")
                    var left = prefix + splitValue[0]
                    var right = splitValue[1]

                    binding.calDisplay.text = removeExtraZero((left.toDouble()+right.toDouble()).toString())
                }
                else{
                    var splitValue = textViewValue.split("/")
                    var left = prefix + splitValue[0]
                    var right = splitValue[1]
                    if(right=="0"){
                        Toast.makeText(this,"Cannot divide by 0",Toast.LENGTH_LONG).show()
                    }else{
                        binding.calDisplay.text = removeExtraZero((left.toDouble()/right.toDouble()).toString())
                    }

                }
            }catch (e: ArithmeticException){
                e.printStackTrace()
            }
        }
    }

    private fun removeExtraZero(result: String):String{
        var value = result
        if(result.contains(".0")){
            value = result.substring(0,result.length-2)
        }
        return value
    }

    private fun isOperatorAdded(value: String):Boolean{
        return if(value.startsWith("-")){
            false
        }else{
            value.contains("/")
                    || value.contains("x")
                    || value.contains("+")
                    || value.contains("-")
        }
    }
}