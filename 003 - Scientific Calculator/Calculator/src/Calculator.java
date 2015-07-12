import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ButtonGroup;
import javax.swing.JFrame;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.JButton;

import java.math.*;


public class Calculator implements ActionListener {
	
	boolean zeroDisplay; //Determines whether the user is allowed to print a 0
	boolean decimalDisplay; //Makes sure only 1 decimal can be placed
	
	private double firstInput; //First input of 2 variable functions
	private double secondInput; //Second input of two variable functions
	private double answer; //Answer variable
	
	private double memory; //Double for storing memory value
	
	private boolean inRad; //Checks if angles are in radians

	
	private byte operation; //Used for identifying functions

	JFrame frame = new JFrame("Simple Scientific Calculator - Wasserman");
	

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Calculator window = new Calculator();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	public Calculator() {
		Buttons();
	}

	
	
	@Override
	public void actionPerformed(ActionEvent ae) {
		String action = ae.getActionCommand();
		
		//When event happends checksa following cases
		switch(action) {
			case "0":	System.out.println("You pressed '0'");
			
						if(!zeroDisplay && !decimalDisplay) { //Prevents people from over-using zeroes before numbers unless it is after a decimal point
							display1.setText(null);
						}
						display1.setText(display1.getText() + "0");
						break;
						
			case "1":	System.out.println("You pressed '1'");
			
						if(!zeroDisplay && !decimalDisplay) {
							display1.setText(null);
						}
						display1.setText(display1.getText() + "1");
						zeroDisplay = true;
						break;
						
			case "2":	System.out.println("You pressed '2'");
			
						if(!zeroDisplay && !decimalDisplay) { 
							display1.setText(null);
						}
						display1.setText(display1.getText() + "2");
						zeroDisplay = true;
						break;
						
			case "3":	System.out.println("You pressed '3'");
			
						if(!zeroDisplay && !decimalDisplay) { 
							display1.setText(null);
						}
						display1.setText(display1.getText() + "3");
						zeroDisplay = true;
						break;
			case "4":	System.out.println("You pressed '4'");
			
						if(!zeroDisplay && !decimalDisplay) {
							display1.setText(null);
						}
						display1.setText(display1.getText() + "4");
						zeroDisplay = true;
						break;
			case "5":	System.out.println("You pressed '5'");
			
						if(!zeroDisplay && !decimalDisplay) { 
							display1.setText(null);
						}
						display1.setText(display1.getText() + "5");
						zeroDisplay = true;
						break;
			case "6":	System.out.println("You pressed '6'");
			
						if(!zeroDisplay && !decimalDisplay) {
							display1.setText(null);
						}
						display1.setText(display1.getText() + "6");
						zeroDisplay = true;
						break;
			case "7":	System.out.println("You pressed '7'");
			
						if(!zeroDisplay && !decimalDisplay) {
							display1.setText(null);
						}
						display1.setText(display1.getText() + "7");
						zeroDisplay = true;
						break;
			case "8":	System.out.println("You pressed '8'");
			
						if(!zeroDisplay && !decimalDisplay) {
							display1.setText(null);
						}
						display1.setText(display1.getText() + "8");
						zeroDisplay = true;
						break;
			case "9":	System.out.println("You pressed '9'");
			
						if(!zeroDisplay && !decimalDisplay) { 
							display1.setText(null);
						}
						display1.setText(display1.getText() + "9");
						zeroDisplay = true;
						break;
						
			case ".":	System.out.println("You entered a decimal point");
						if(!decimalDisplay) {
							display1.setText(display1.getText() + ".");
							decimalDisplay = true;
						}
						break;
			case "±": 	System.out.println("You toggled ±");
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = -1 * secondInput;
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						decimalDisplay = true;
						answer = 0;
						break;
			case "CE":  System.out.println("You cleared entry");
						display1.setText("0");
						zeroDisplay = false;
						decimalDisplay = false;
						break;
			case "C":   System.out.println("Reset");
						display1.setText("0");
						display2.setText(null);
						zeroDisplay = false;
						decimalDisplay = false;
						firstInput = 0;
						secondInput = 0;
						answer = 0;
						break;
			case "∏":   System.out.println("Pi (∏)");
						
						if(!zeroDisplay && !decimalDisplay) { 
							display1.setText(null);
						}
						display1.setText(String.valueOf(Math.PI));
						zeroDisplay = true;
						break;
			case "E":   System.out.println("E");
			
						if(!zeroDisplay && !decimalDisplay) { 
							display1.setText(null);
						}
						display1.setText(String.valueOf(Math.E));
						zeroDisplay = true;
						break;
			case "Log": System.out.println("Log");
			
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = Math.log10(secondInput);
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("Log(" + secondInput + ") = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "1/X": System.out.println("1/X");
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = 1/(secondInput);
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("(1/" + secondInput + ") = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "√":   System.out.println("Square Root");
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = Math.sqrt(secondInput);
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("(√" + secondInput + ") = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "X!":  System.out.println("Factorial!");
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = factorial(secondInput);
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("(" + secondInput + "!) = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "X²":  System.out.println("X²");
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = (secondInput)*(secondInput);
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("(" + secondInput + "²) = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "10ˣ": System.out.println("10ˣ");
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = Math.pow(10, (secondInput));
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("10^" + secondInput + " = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "ln":  System.out.println("ln");
			
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						answer = Math.log(secondInput);
						
						if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
							display1.setText(String.valueOf(answer));
						}
						else {
							display1.setText("Error");
						}
						
						display2.setText("ln(" + secondInput + ") = " + answer);
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "Sin": System.out.println("Sin");
			
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						
						//If not in radians it converts the value before finding the sin
				        if(!inRad){
				        	display2.setText("Sin(" + String.valueOf(secondInput) + ")");
				            secondInput = secondInput * 0.0174532925;
				        }
				        answer = Math.sin(secondInput);
						
				        
				        display2.setText("Sin(" + String.valueOf(secondInput) + ")");
				        display1.setText(String.valueOf(answer));

						
						decimalDisplay = true;
						answer = 0;
						break;
						
			case "Cos": System.out.println("Cos");
			
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						
						//If not in radians it converts the value before finding the cos
				        if(!inRad){
				        	display2.setText("Cos(" + String.valueOf(secondInput) + ")");
				            secondInput = secondInput * 0.0174532925;
				        }
				        answer = Math.cos(secondInput);
						
				        
				        display2.setText("Cos(" + String.valueOf(secondInput) + ")");
				        display1.setText(String.valueOf(answer));
			
						
						decimalDisplay = true;
						answer = 0;
						break;
						
			case "Tan": System.out.println("Tan");
						
						secondInput = Double.parseDouble(String.valueOf(display1.getText()));
						
						//If not in radians it converts the value before finding the tan
				        if(!inRad){
				        	display2.setText("Tan(" + String.valueOf(secondInput) + ")");
				            secondInput = secondInput * 0.0174532925;
				        }
				        answer = Math.tan(secondInput);
						
				        
				        display2.setText("Tan(" + String.valueOf(secondInput) + ")");
				        display1.setText(String.valueOf(answer));
			
						
						decimalDisplay = true;
						answer = 0;
						break;
			case "MC":  
						memory = 0;
						break;
						
			case "MR":  
						display1.setText(String.valueOf(memory));
						break;
						
			case "MS":	memory = Double.parseDouble(String.valueOf(display1.getText()));
						break;
						
			case "M+":  memory = memory + Double.parseDouble(String.valueOf(display1.getText()));
						break;
			
			case "M-":  memory = memory - Double.parseDouble(String.valueOf(display1.getText()));
						break;
						}
					}
	
	private double factorial(double n) {
	    double num = n;
	    double total = 1;
	    if(num != 0 | num != 1){
	        total = num;
	    }else if(num == 1 | num == 0){
	        total = 1;
	    }
	    double num2;
	    while(num > 1){
	        num2 = num - 1;
	        total = total * num2;
	        num = num - 1;
	    }
	    return total;
	}
	

	JTextField display2 = new JTextField(55);
	JTextField display1 = new JTextField(55);
	
	private void addActionPerformed(java.awt.event.ActionEvent evt) {
		System.out.println("Addition");
		if(operation == 0){
            firstInput = Double.parseDouble(String.valueOf(display1.getText()));
        }
        else{
            secondInput = Double.parseDouble(String.valueOf(display1.getText()));
        }
        
        if(operation == 1){
            firstInput = firstInput + secondInput;
        }
        
        if(operation == 2){
            firstInput = firstInput - secondInput;
        }
        
        if(operation == 3){
            firstInput = firstInput * secondInput;
        }
        
        if(operation == 4){
            firstInput = firstInput / secondInput;
        }
        
        
        display1.setText("0");
        display2.setText(String.valueOf(firstInput) + " + ");
        
        operation = 1;
        
        decimalDisplay = false;
        zeroDisplay = false;
	
	}
	
	private void subtractActionPerformed(java.awt.event.ActionEvent evt) {
		System.out.println("Subtraction");
		if(operation == 0) {
			firstInput = Double.parseDouble(String.valueOf(display1.getText()));
		}
		else {
			secondInput = Double.parseDouble(String.valueOf(display1.getText()));
		}
		
		if(operation == 1) {
			firstInput += secondInput;	
		}
		
		if(operation == 2) {
			firstInput -= secondInput;	
		}
		
		if(operation == 3) {
			firstInput *= secondInput;	
		}
		
		if(operation == 4) {
			firstInput /= secondInput;	
		}
		
		display1.setText("0");
		display2.setText(String.valueOf(firstInput) + " - ");
		
		operation = 2;
		
		decimalDisplay = false;
		zeroDisplay = false;
		
	}
	
	private void multiplyActionPerformed(java.awt.event.ActionEvent evt) {
		System.out.println("Multplication");
		if(operation == 0) {
			firstInput = Double.parseDouble(String.valueOf(display1.getText()));
		}
		else {
			secondInput = Double.parseDouble(String.valueOf(display1.getText()));
		}
		
		if(operation == 1) {
			firstInput += secondInput;	
		}
		
		if(operation == 2) {
			firstInput -= secondInput;	
		}
		
		if(operation == 3) {
			firstInput *= secondInput;	
		}
		
		if(operation == 4) {
			firstInput /= secondInput;	
		}
		
		display1.setText("0");
		display2.setText(String.valueOf(firstInput) + " * ");
		
		operation = 3;
		
		decimalDisplay = false;
		zeroDisplay = false;
		
	}
	
	private void divideActionPerformed(java.awt.event.ActionEvent evt) {
		System.out.println("Division");
		if(operation == 0) {
			firstInput = Double.parseDouble(String.valueOf(display1.getText()));
		}
		else {
			secondInput = Double.parseDouble(String.valueOf(display1.getText()));
		}
		
		if(operation == 1) {
			firstInput += secondInput;	
		}
		
		if(operation == 2) {
			firstInput -= secondInput;	
		}
		
		if(operation == 3) {
			firstInput = firstInput * secondInput;	
		}
		
		if(operation == 4) {
			firstInput = firstInput / secondInput;	
		}
		
		display1.setText("0");
		display2.setText(String.valueOf(firstInput) + " / ");
		
		operation = 4;
		
		decimalDisplay = false;
		zeroDisplay = false; 
		
	}
	
	private void equalsActionPerformed(java.awt.event.ActionEvent evt) {
		System.out.println("Equals");
		secondInput = Double.parseDouble(String.valueOf(display1.getText()));
		
		if(operation == 0) {
			answer = secondInput;
			display2.setText(String.valueOf(secondInput));
		}
		if(operation == 1) {
			answer = firstInput + secondInput;
			display2.setText(display2.getText() + String.valueOf(secondInput));
		} 
		if(operation == 2) {
			answer = firstInput - secondInput;
			display2.setText(display2.getText() + String.valueOf(secondInput));
		}
		if(operation == 3) {
			answer = firstInput * secondInput;
			display2.setText(display2.getText() + String.valueOf(secondInput));
		}
		if(operation == 4) {
			answer = firstInput / secondInput;
			display2.setText(display2.getText() + String.valueOf(secondInput));
		}		
		
		if(answer > -1000000000 && answer < 1000000000) { //Displays error if value is out of range
			display1.setText(String.valueOf(answer));
		}
		else {
			display1.setText("Error");
		}
		operation = 0;
		answer = 0;
		firstInput = 0;
		secondInput = 0;
		decimalDisplay = false;
		zeroDisplay = false;
	
	}
	
	private void degreesActionPerformed(java.awt.event.ActionEvent evt) {
        inRad = false;
    }

    private void radiansActionPerformed(java.awt.event.ActionEvent evt) {
    	inRad = true;
    }
	
    
    //Initializes buttons, places them, and sets action listeners
	void Buttons() {

		frame.getContentPane().setLayout(null);
		frame.setSize(525, 335);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
		frame.setResizable(false);
		
		
		display2.setPreferredSize(new Dimension(600, 40));
		display2.setBounds(10, 10, 498, 40);
		display2.setEditable(false);
		frame.getContentPane().add(display2);	
		
		
		display1.setPreferredSize(new Dimension(600, 40));
		display1.setBounds(10, 60, 498, 40);
		display1.setEditable(false);
		frame.getContentPane().add(display1);	
		
		
		JRadioButton rad = new JRadioButton("Radians");
		rad.setBounds(115, 106, 80, 30);
		rad.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				radiansActionPerformed(evt);
			}
		});
		frame.getContentPane().add(rad);
		
		JRadioButton deg = new JRadioButton("Degrees");
		deg.setSelected(true);
		deg.setBounds(33, 106, 80, 30);
		deg.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				degreesActionPerformed(evt);
			}
		});
		frame.getContentPane().add(deg);
		
		ButtonGroup angles = new ButtonGroup();
		angles.add(deg);
		angles.add(rad);
		
		JButton mc = new JButton("MC");
		mc.setPreferredSize(new Dimension(58, 30));
		mc.setBounds(199, 106, 58, 30);
		mc.addActionListener(this);
		frame.getContentPane().add(mc);	
		JButton mr = new JButton("MR");
		mr.setPreferredSize(new Dimension(58, 30));
		mr.setBounds(261, 106, 58, 30);
		mr.addActionListener(this);
		frame.getContentPane().add(mr);	
		JButton ms = new JButton("MS");
		ms.setPreferredSize(new Dimension(58, 30));
		ms.setBounds(325, 106, 58, 30);
		ms.addActionListener(this);
		frame.getContentPane().add(ms);
		JButton mplus = new JButton("M+");
		mplus.setPreferredSize(new Dimension(58, 30));
		mplus.setBounds(388, 106, 58, 30);
		mplus.addActionListener(this);
		frame.getContentPane().add(mplus);		
		JButton mminus = new JButton("M-");
		mminus.setPreferredSize(new Dimension(58, 30));
		mminus.setBounds(451, 106, 58, 30);
		mminus.addActionListener(this);
		frame.getContentPane().add(mminus);
		
		JButton factorial = new JButton("X!");
		factorial.setPreferredSize(new Dimension(58, 30));
		factorial.setBounds(73, 270, 58, 30);
		factorial.addActionListener(this);
		frame.getContentPane().add(factorial);
		JButton pi = new JButton("∏");
		pi.setPreferredSize(new Dimension(58, 30));
		pi.setBounds(10, 147, 58, 30);
		pi.addActionListener(this);
		frame.getContentPane().add(pi);
		JButton sin = new JButton("Sin");
		sin.setBounds(73, 147, 58, 30);
		sin.setPreferredSize(new Dimension(58, 30));
		sin.addActionListener(this);
		frame.getContentPane().add(sin);
		JButton xsquared = new JButton("X²");
		xsquared.setPreferredSize(new Dimension(58, 30));
		xsquared.setBounds(137, 147, 58, 30);
		xsquared.addActionListener(this);
		frame.getContentPane().add(xsquared);
		
		JButton seven = new JButton("7");
		seven.setPreferredSize(new Dimension(58, 30));
		seven.setBounds(199, 147, 58, 30);
		seven.addActionListener(this);
		frame.getContentPane().add(seven);
		JButton eight = new JButton("8");
		eight.setPreferredSize(new Dimension(58, 30));
		eight.setBounds(261, 147, 58, 30);
		eight.addActionListener(this);
		frame.getContentPane().add(eight);
		JButton nine = new JButton("9");
		nine.setPreferredSize(new Dimension(58, 30));
		nine.setBounds(325, 147, 58, 30);
		nine.addActionListener(this);
		frame.getContentPane().add(nine);
		JButton plus = new JButton("+");
		plus.setPreferredSize(new Dimension(58, 30));
		plus.setBounds(388, 147, 58, 30);
		plus.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				addActionPerformed(evt);
			}
		});
		frame.getContentPane().add(plus);
		JButton ce = new JButton("CE");
		ce.setPreferredSize(new Dimension(58, 30));
		ce.setBounds(451, 147, 58, 30);
		ce.addActionListener(this);
		frame.getContentPane().add(ce);
		JButton e = new JButton("E");
		e.setPreferredSize(new Dimension(58, 30));
		e.setBounds(10, 188, 58, 30);
		e.addActionListener(this);
		frame.getContentPane().add(e);
		JButton cos = new JButton("Cos");
		cos.setPreferredSize(new Dimension(58, 30));
		cos.setBounds(73, 188, 58, 30);
		cos.addActionListener(this);
		frame.getContentPane().add(cos);
		JButton oneoverx = new JButton("1/X");
		oneoverx.setPreferredSize(new Dimension(58, 30));
		oneoverx.setBounds(137, 229, 58, 30);
		oneoverx.addActionListener(this);
		frame.getContentPane().add(oneoverx);
		
		JButton sqrt = new JButton("√");
		sqrt.setPreferredSize(new Dimension(58, 30));
		sqrt.setBounds(137, 188, 58, 30);
		sqrt.addActionListener(this);
		frame.getContentPane().add(sqrt);
		
		JButton four = new JButton("4");
		four.setPreferredSize(new Dimension(58, 30));
		four.setBounds(199, 188, 58, 30);
		four.addActionListener(this);
		frame.getContentPane().add(four);
		JButton five = new JButton("5");
		five.setPreferredSize(new Dimension(58, 30));
		five.setBounds(261, 188, 58, 30);
		five.addActionListener(this);
		frame.getContentPane().add(five);
		JButton six = new JButton("6");
		six.setPreferredSize(new Dimension(58, 30));
		six.setBounds(325, 188, 58, 30);
		six.addActionListener(this);
		frame.getContentPane().add(six);
		JButton minus = new JButton("-");
		minus.setPreferredSize(new Dimension(58, 30));
		minus.setBounds(388, 188, 58, 30);
		minus.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				subtractActionPerformed(evt);
			}
		});
		frame.getContentPane().add(minus);
		JButton c = new JButton("C");
		c.setPreferredSize(new Dimension(58, 30));
		c.setBounds(451, 188, 58, 30);
		c.addActionListener(this);
		frame.getContentPane().add(c);
		JButton ln = new JButton("ln");
		ln.setPreferredSize(new Dimension(58, 30));
		ln.setBounds(10, 229, 58, 30);
		ln.addActionListener(this);
		frame.getContentPane().add(ln);
		JButton tan = new JButton("Tan");
		tan.setPreferredSize(new Dimension(58, 30));
		tan.setBounds(73, 229, 58, 30);
		tan.addActionListener(this);
		frame.getContentPane().add(tan);
		JButton log = new JButton("Log");
		log.setPreferredSize(new Dimension(58, 30));
		log.setBounds(10, 270, 58, 30);
		log.addActionListener(this);
		frame.getContentPane().add(log);
		JButton pm = new JButton("±");
		pm.setPreferredSize(new Dimension(58, 30));
		pm.setBounds(137, 270, 58, 30);
		pm.addActionListener(this);
		frame.getContentPane().add(pm);
		
		JButton one = new JButton("1");
		one.setPreferredSize(new Dimension(58, 30));
		one.setBounds(199, 229, 58, 30);
		one.addActionListener(this);
		frame.getContentPane().add(one);
		JButton two = new JButton("2");
		two.setPreferredSize(new Dimension(58, 30));
		two.setBounds(261, 229, 58, 30);
		two.addActionListener(this);
		frame.getContentPane().add(two);
		JButton three = new JButton("3");
		three.setPreferredSize(new Dimension(58, 30));
		three.setBounds(325, 229, 58, 30);
		three.addActionListener(this);
		frame.getContentPane().add(three);
		JButton mult = new JButton("*");
		mult.setPreferredSize(new Dimension(58, 30));
		mult.setBounds(388, 229, 58, 30);
		mult.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				multiplyActionPerformed(evt);
			}
		});
		frame.getContentPane().add(mult);
		JButton equal = new JButton("=");
		equal.setPreferredSize(new Dimension(58, 30));
		equal.setBounds(451, 229, 58, 71);
		equal.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				equalsActionPerformed(evt);
			}
		});
		frame.getContentPane().add(equal);
		
		JButton zero = new JButton("0");
		zero.setPreferredSize(new Dimension(116, 30));
		zero.setBounds(198, 270, 121, 30);
		zero.addActionListener(this);
		frame.getContentPane().add(zero);
		JButton dec = new JButton(".");
		dec.setPreferredSize(new Dimension(58, 30));
		dec.setBounds(325, 270, 58, 30);
		dec.addActionListener(this);
		frame.getContentPane().add(dec);
		JButton div = new JButton("/");
		div.setPreferredSize(new Dimension(58, 30));
		div.setBounds(388, 270, 58, 30);
		div.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent evt) {
				divideActionPerformed(evt);
			}
		});
		frame.getContentPane().add(div);
	}
}