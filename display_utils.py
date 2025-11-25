"""
Display utilities for control systems analysis.

This module provides pretty-printing functions for state-space models
and other control system objects, with LaTeX rendering support for Jupyter notebooks.
"""

from sympy import Matrix, latex, simplify, nsimplify, Rational
from IPython.display import display, Math, Markdown
import numpy as np


def ss(sys_ss, title=None, simplify_numbers=True, precision=4):
    """
    Display a state-space system with LaTeX rendering in Jupyter notebooks.
    
    Parameters
    ----------
    sys_ss : StateSpace
        The state-space system to display (from python-control library)
    title : str, optional
        Title to display above the system. Default is "State-Space System"
    simplify_numbers : bool, optional
        If True, attempts to convert floating point numbers to rational fractions.
        Default is True.
    precision : int, optional
        Number of decimal places for floating point display. Default is 4.
    
    Examples
    --------
    >>> import control as ct
    >>> from display_utils import display_statespace
    >>> sys = ct.tf([1, 1], [1, 2, 1])
    >>> ss = ct.ss(sys)
    >>> display_statespace(ss, title="Example System")
    """
    if title is None:
        title = "State-Space System"
    
    # Convert numpy arrays to SymPy matrices
    def to_sympy_matrix(arr, simplify_nums=simplify_numbers, prec=precision):
        """Convert numpy array to SymPy matrix with optional simplification."""
        if simplify_nums:
            # Try to convert to rational numbers
            try:
                # Use nsimplify to find rational approximations
                sym_mat = Matrix(arr).applyfunc(
                    lambda x: nsimplify(x, rational=True, tolerance=10**(-prec))
                )
                return sym_mat
            except:
                # Fallback to regular conversion
                return Matrix(arr)
        else:
            return Matrix(arr)
    
    A_sym = to_sympy_matrix(sys_ss.A)
    B_sym = to_sympy_matrix(sys_ss.B)
    C_sym = to_sympy_matrix(sys_ss.C)
    D_sym = to_sympy_matrix(sys_ss.D)
    
    # Display the system
    display(Markdown(f"### {title}"))
    display(Markdown(f"**System dimensions:** {sys_ss.nstates} states, "
                     f"{sys_ss.ninputs} input(s), {sys_ss.noutputs} output(s)"))
    
    # Display state equations
    display(Markdown("**State-space equations:**"))
    display(Math(r'\dot{\mathbf{x}} = A\mathbf{x} + B\mathbf{u}'))
    display(Math(r'\mathbf{y} = C\mathbf{x} + D\mathbf{u}'))
    
    # Display matrices
    display(Markdown("**System matrices:**"))
    display(Math(f'A = {latex(A_sym)}'))
    display(Math(f'B = {latex(B_sym)}'))
    display(Math(f'C = {latex(C_sym)}'))
    display(Math(f'D = {latex(D_sym)}'))

def tf(sys_tf, title=None):
    """
    Display a transfer function with LaTeX rendering.
    
    Parameters
    ----------
    sys_tf : TransferFunction
        The transfer function to display
    title : str, optional
        Title to display above the transfer function
    """
    if title is None:
        title = "Transfer Function"
    
    display(Markdown(f"### {title}"))
    
    # Get numerator and denominator
    num = sys_tf.num[0][0]
    den = sys_tf.den[0][0]
    
    # Build LaTeX polynomial string
    def poly_to_latex(coeffs, var='s'):
        """Convert polynomial coefficients to LaTeX string."""
        terms = []
        n = len(coeffs) - 1
        for i, coef in enumerate(coeffs):
            if abs(coef) < 1e-10:  # Skip near-zero coefficients
                continue
            power = n - i
            if power == 0:
                terms.append(f"{coef:g}")
            elif power == 1:
                if coef == 1:
                    terms.append(f"{var}")
                elif coef == -1:
                    terms.append(f"-{var}")
                else:
                    terms.append(f"{coef:g}{var}")
            else:
                if coef == 1:
                    terms.append(f"{var}^{{{power}}}")
                elif coef == -1:
                    terms.append(f"-{var}^{{{power}}}")
                else:
                    terms.append(f"{coef:g}{var}^{{{power}}}")
        
        if not terms:
            return "0"
        
        # Join with + and -, handling signs
        result = terms[0]
        for term in terms[1:]:
            if term.startswith('-'):
                result += f" - {term[1:]}"
            else:
                result += f" + {term}"
        return result
    
    num_latex = poly_to_latex(num)
    den_latex = poly_to_latex(den)
    
    display(Math(f'G(s) = \\frac{{{num_latex}}}{{{den_latex}}}'))


# Convenience function that auto-detects type
def sys(sys, title=None, **kwargs):
    """
    Automatically display a control system (state-space or transfer function).
    
    Parameters
    ----------
    sys : StateSpace or TransferFunction
        The system to display
    title : str, optional
        Title to display
    **kwargs : dict
        Additional arguments passed to the specific display function
    """
    # Check system type
    sys_type = type(sys).__name__
    
    if 'StateSpace' in sys_type:
        ss(sys, title=title, **kwargs)
    elif 'TransferFunction' in sys_type:
        tf(sys, title=title, **kwargs)
    else:
        display(Markdown(f"### {title if title else 'System'}"))
        display(Markdown(f"**Type:** {sys_type}"))
        print(sys)
