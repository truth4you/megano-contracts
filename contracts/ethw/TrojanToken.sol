// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
// import "hardhat/console.sol";
library SafeMathInt {
    int256 private constant MIN_INT256 = int256(1) << 255;
    int256 private constant MAX_INT256 = ~(int256(1) << 255);

    function mul(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a * b;

        require(c != MIN_INT256 || (a & MIN_INT256) != (b & MIN_INT256));
        require((b == 0) || (c / b == a), 'mul overflow');
        return c;
    }

    function div(int256 a, int256 b) internal pure returns (int256) {
        require(b != -1 || a != MIN_INT256);

        return a / b;
    }

    function sub(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a - b;
        require((b >= 0 && c <= a) || (b < 0 && c > a),
            'sub overflow');
        return c;
    }

    function add(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a + b;
        require((b >= 0 && c >= a) || (b < 0 && c < a),
            'add overflow');
        return c;
    }

    function abs(int256 a) internal pure returns (int256) {
        require(a != MIN_INT256,
            'abs overflow');
        return a < 0 ? -a : a;
    }

    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'SafeMath: addition overflow');

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, 'SafeMath: subtraction overflow');
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, 'SafeMath: multiplication overflow');

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, 'SafeMath: division by zero');
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0,
            'parameter 2 can not be 0');
        return a % b;
    }

    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IDEXRouter is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}
interface IDEXPair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint);

    function permit(
        address owner,
        address spender,
        uint value,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint);

    function price1CumulativeLast() external view returns (uint);

    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);

    function burn(address to) external returns (uint amount0, uint amount1);

    function swap(
        uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface IDEXFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}


/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) public {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}
// import "hardhat/console.sol";

interface InterfaceLP {
    function sync() external;
}

struct LockInfo {
    uint32 locked;      // timestamp of lock
    uint32 unlocked;    // timestamp of unlock
    uint32 duration;    // duration of lock
    uint256 amount;
}

contract MEGANO is ERC20{
    using SafeMath for uint256;
    using SafeMathInt for int256;

    bool public initialDistributionFinished;
    bool public swapEnabled;
    bool public autoRebase;
    bool public feesOnNormalTransfers;
    bool public isBurnEnabled;
    bool public taxNonMarketMaker;

    uint256 public rebaseIndex;
    uint256 public oneEEighteen;
    uint256 public rewardExtra;
    uint256 public rewardYield;
    uint256 public rewardYieldDenominator;
    uint256 public maxSellTransactionAmount;
    uint256 public maxBuyTransactionAmount;

    uint32 public minExtraDays;
    uint32 public maxExtraDays;
    uint256 public minExtraAmount;
    uint256 public maxExtraAmount;

    uint256 public rebaseFrequency;
    uint256 public nextRebase;
    uint256 public rebaseEpoch;
    uint256 public nonMarketMakerFee;

    mapping(address => bool) _isFeeExempt;
    address[] public _markerPairs;
    uint256 public _markerPairCount;
    mapping(address => bool) public automatedMarketMakerPairs;

    uint256 public MAX_FEE_RATE;
    uint256 public MIN_SELL_AMOUNT_RATE;
    uint256 public MIN_BUY_AMOUNT_RATE;
    uint256 private MAX_REBASE_FREQUENCY;
    uint256 public feeDenominator;

    uint256 private DECIMALS;
    uint256 private MAX_UINT256;
    uint256 private INITIAL_FRAGMENTS_SUPPLY;
    uint256 private TOTAL_GONS;
    uint256 private MAX_SUPPLY;

    address private constant DEAD = 0x000000000000000000000000000000000000dEaD;
    address private constant ZERO = 0x0000000000000000000000000000000000000000;
    address private constant LOCK = 0x000000000000000000000000000000000000CcCc;

    address public liquidityReceiver;
    address public treasuryReceiver;
    address public riskFreeValueReceiver;

    IDEXRouter public router;
    IDEXFactory public factory;
    IDEXPair public iDexPair;
    address public pair;

    uint256 private constant maxBracketTax = 10; // max bracket is holding 10%

    uint256 public liquidityFee;
    uint256 public treasuryFee;
    uint256 public burnFee;
    uint256 public sellBurnFee;
    uint256 public buyFeeRFV;
    uint256 public sellFeeTreasuryAdded;
    uint256 public sellFeeRFVAdded;
    uint256 public totalBuyFee;
    uint256 public totalSellFee;
    uint256 targetLiquidity;
    uint256 targetLiquidityDenominator;

    uint256 private _totalSupply;
    uint256 private _gonsPerFragment;
    uint256 private gonSwapThreshold;
    address public owner;
    mapping(address => uint256) private _gonBalances;
    mapping(address => bool) private holders;
    uint32 public numberOfHolders;
    mapping(address => mapping(address => uint256)) private _allowedFragments;
    mapping(address => LockInfo[]) public lockHistory;
    uint256 public totalLocked;
    uint256 public totalRewarded;
    uint32 public totalLockedHolders;
    mapping(uint256 => uint256) private _powers;

    // uint32 public constant PRICE_PERIOD = 24 hours;
    // uint32 public priceTimestampLast;
    // uint256 public priceCumulativeLast;
    // uint256 public priceAverage;

    bool inSwap;

    event SwapBack(
        uint256 contractTokenBalance,
        uint256 amountToLiquify,
        uint256 amountToRFV,
        uint256 amountToTreasury
    );

    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 MATICReceived,
        uint256 tokensIntoLiqudity
    );

    event SetFeeReceivers(
        address indexed _liquidityReceiver,
        address indexed _treasuryReceiver,
        address indexed _riskFreeValueReceiver
    );

    event ClearStuckBalance(
        uint256 indexed amount,
        address indexed receiver,
        uint256 indexed time
    );

    event RescueToken(
        address indexed tokenAddress,
        address indexed sender,
        uint256 indexed tokens,
        uint256 time
    );

    event SetAutoRebase(
        bool indexed value,
        uint256 indexed time
    );

    event SetRebaseFrequency(
        uint256 indexed frequency,
        uint256 indexed time
    );

    event SetRewardYield(
        uint256 indexed rewardYield,
        uint256 indexed frequency,
        uint256 indexed time
    );

    event SetFeesOnNormalTransfers(
        bool indexed value,
        uint256 indexed time
    );

    event SetNextRebase(
        uint256 indexed value,
        uint256 indexed time
    );

    event SetMaxSellTransaction(
        uint256 indexed value,
        uint256 indexed time
    );

    event SetMaxBuyTransactionAmount(
        uint256 indexed value,
        uint256 indexed time
    );

    event SetBurnFee(
        bool indexed value,
        uint256 indexed time
    );

    event SetSwapBackSettings(
        bool indexed enabled,
        uint256 indexed num,
        uint256 indexed denum
    );

    event TaxNonMarketMakerSet(bool value, uint256 time);
    event SetTargetLiquidity(uint256 indexed target, uint256 indexed accuracy);

    event SetFees(
        uint256 indexed _liquidityFee,
        uint256 indexed _riskFreeValue,
        uint256 indexed _treasuryFee,
        uint256 _sellFeeTreasuryAdded,
        uint256 _sellFeeRFVAdded,
        uint256 _burnFee,
        uint256 sellBurnFee,
        uint256 totalBuyFee
    );

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);
    event LogManualRebase(uint256 circulatingSupply, uint256 timeStamp);
    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);
    event SetInitialDistribution(bool indexed value);
    event SetFeeExempt(address indexed addy, bool indexed value);

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    constructor() ERC20("MEGANO", "MEGANO") {
        
        owner = msg.sender;
        initialDistributionFinished = false;
        swapEnabled = true;
        autoRebase = false;
        feesOnNormalTransfers = false;
        isBurnEnabled = false;
        taxNonMarketMaker = false;

        rebaseIndex = 1 * 10**18;
        oneEEighteen = 1 * 10**18;
        rewardExtra = 1000000000000; // 0.01%
        rewardYield = 200000000000000; // 2%
        rewardYieldDenominator = 10000000000000000;
        maxSellTransactionAmount = 2500000 * 10**18;
        maxBuyTransactionAmount = 2500000 * 10**18;

        rebaseFrequency = 24 hours;
        nextRebase = block.timestamp + rebaseFrequency;
        rebaseEpoch = 0;
        nonMarketMakerFee = 5;

        liquidityReceiver = msg.sender;
        treasuryReceiver = 0x37112CB8E83B30B24bB39f453dcEE69f8cA61058;
        riskFreeValueReceiver = 0x37112CB8E83B30B24bB39f453dcEE69f8cA61058;

        liquidityFee = 5;
        treasuryFee = 3;
        burnFee = 0;
        sellBurnFee = 0;
        buyFeeRFV = 5;
        sellFeeTreasuryAdded = 2;
        sellFeeRFVAdded = 5;

        minExtraDays = 7;
        maxExtraDays = 365;
        minExtraAmount = 0.1 ether;
        maxExtraAmount = 100 ether;
        
        targetLiquidity = 50;
        targetLiquidityDenominator = 100;

        router = IDEXRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);// main
        // router = IDEXRouter(0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0); //local
        pair = IDEXFactory(router.factory()).createPair(address(this), router.WETH());

        MAX_FEE_RATE = 25;
        MIN_SELL_AMOUNT_RATE = 1500000 * 10**18;
        MIN_BUY_AMOUNT_RATE = 1500000 * 10**18;
        MAX_REBASE_FREQUENCY = 1800; // 30 min
        feeDenominator = 100;

        DECIMALS = 18;
        MAX_UINT256 = ~uint256(0);
        INITIAL_FRAGMENTS_SUPPLY = 5 * 10**9 * 10**DECIMALS;
        TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);
        MAX_SUPPLY = ~uint128(0);

        _allowedFragments[address(this)][address(router)] = ~uint256(0);
        _allowedFragments[address(this)][pair] = ~uint256(0);
        _allowedFragments[address(this)][address(this)] = ~uint256(0);
        _allowedFragments[address(this)][address(LOCK)] = ~uint256(0);

        setAutomatedMarketMakerPair(pair, true);

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
        _gonBalances[msg.sender] = TOTAL_GONS;
        holders[msg.sender] = true;
        numberOfHolders = 1;
        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);

        _isFeeExempt[treasuryReceiver] = true;
        _isFeeExempt[riskFreeValueReceiver] = true;
        _isFeeExempt[address(this)] = true;
        _isFeeExempt[msg.sender] = true;
        _isFeeExempt[address(LOCK)] = true;

        gonSwapThreshold = TOTAL_GONS / 1000;
        totalBuyFee = liquidityFee.add(treasuryFee).add(buyFeeRFV);
        totalSellFee = totalBuyFee.add(sellFeeTreasuryAdded).add(sellFeeRFVAdded);

        emit Transfer(address(0x0), msg.sender, _totalSupply);
    }
    
    function transferOwnership(address account) public onlyOwner {
        owner = account;
    }

    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }

    modifier validRecipient(address to) {
        require(to != address(0x0),'recipient is not valid');
        _;
    }

    receive() external payable {}

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function allowance(address owner_, address spender) public view override returns (uint256) {
        return _allowedFragments[owner_][spender];
    }

    function balanceOf(address who) public view override returns (uint256) {
        return _gonBalances[who].div(_gonsPerFragment);
    }

    function markerPairAddress(uint256 value) public view returns (address) {
        return _markerPairs[value];
    }

    function currentIndex() public view returns (uint256) {
        return rebaseIndex;
    }

    function checkFeeExempt(address _addr) external view returns (bool) {
        return _isFeeExempt[_addr];
    }

    function checkSwapThreshold() external view returns (uint256) {
        return gonSwapThreshold.div(_gonsPerFragment);
    }

    function shouldRebase() internal view returns (bool) {
        return nextRebase <= block.timestamp;
    }

    function shouldBurn() internal view returns (bool) {
        return isBurnEnabled;
    }

    function shouldTakeFee(address from, address to) internal view returns (bool) {
        if (_isFeeExempt[from] || _isFeeExempt[to]) {
            return false;
        } else if (feesOnNormalTransfers) {
            return true;
        } else {
            return (automatedMarketMakerPairs[from] ||
            automatedMarketMakerPairs[to]);
        }
    }

    function shouldSwapBack() internal view returns (bool) {
        return
        !automatedMarketMakerPairs[msg.sender] &&
        !inSwap &&
        swapEnabled &&
        totalBuyFee.add(totalSellFee) > 0 &&
        _gonBalances[address(this)] >= gonSwapThreshold;
    }

    function getGonBalances() public view returns (bool thresholdReturn, uint256 gonBalanceReturn ) {
        thresholdReturn  = _gonBalances[address(this)] >= gonSwapThreshold;
        gonBalanceReturn = _gonBalances[address(this)];
    }

    function getCirculatingSupply() public view returns (uint256) {
        return
        (TOTAL_GONS.sub(_gonBalances[LOCK]).sub(_gonBalances[DEAD]).sub(_gonBalances[ZERO])).div(_gonsPerFragment);
    }

    function getCurrentTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    function getLiquidityBacking(uint256 accuracy) public view returns (uint256) {
        uint256 liquidityBalance = 0;
        for (uint256 i = 0; i < _markerPairs.length; i++) {
            liquidityBalance.add(balanceOf(_markerPairs[i]).div(10**9));
        }

        return
        accuracy.mul(liquidityBalance.mul(2)).div(
            getCirculatingSupply().div(10**9)
        );
    }

    function getTokensInLPCirculation() public view returns (uint256) {
        uint112 reserve0;
        uint112 reserve1;
        uint32 blockTimestampLast;
        address token0;
        address token1;
        IDEXPair iDexFeeCalculator;
        uint256 LPTotal;

        for (uint256 i = 0; i < _markerPairs.length; i++) {
            iDexFeeCalculator = IDEXPair(_markerPairs[i]);
            (reserve0, reserve1, blockTimestampLast) = iDexFeeCalculator
            .getReserves();

            token0 = iDexFeeCalculator.token0();
            token1 = iDexFeeCalculator.token1();

            if (token0 == address(this)) {
                LPTotal += reserve0;
                //first one
            } else if (token1 == address(this)) {
                LPTotal += reserve1;
            }
        }

        return LPTotal;
    }

    function getOneTokenInLPCirculation(uint256 _id)
    public
    view
    returns (
        uint256 LPTotal,
        uint112 reserve0,
        uint112 reserve1
    )
    {
        uint32 blockTimestampLast;
        address token0;
        address token1;
        IDEXPair iDexFeeCalculator;

        iDexFeeCalculator = IDEXPair(_markerPairs[_id]);
        (reserve0, reserve1, blockTimestampLast) = iDexFeeCalculator
        .getReserves();

        token0 = iDexFeeCalculator.token0();
        token1 = iDexFeeCalculator.token1();

        if (token0 == address(this)) {
            LPTotal += reserve0;
        } else if (token1 == address(this)) {
            LPTotal += reserve1;
        }

        return (LPTotal, reserve0, reserve1);
    }

    function isOverLiquified(uint256 target, uint256 accuracy)
    public
    view
    returns (bool)
    {
        return getLiquidityBacking(accuracy) > target;
    }

    function manualSync() public {
        for (uint256 i = 0; i < _markerPairs.length; i++) {
            IDEXPair(_markerPairs[i]).sync();
        }
    }

    function transfer(address to, uint256 value)
    public
    override
    validRecipient(to)
    returns (bool)
    {
        _transferFrom(msg.sender, to, value);
        return true;
    }

    function _basicTransfer(
        address from,
        address to,
        uint256 amount
    ) internal returns (bool) {
        uint256 gonAmount = amount.mul(_gonsPerFragment);
        _gonBalances[from] = _gonBalances[from].sub(gonAmount);
        _gonBalances[to] = _gonBalances[to].add(gonAmount);

        emit Transfer(from, to, amount);

        return true;
    }

    function _transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) internal returns (bool) {
        bool excludedAccount = _isFeeExempt[sender] || _isFeeExempt[recipient];

        require(
            initialDistributionFinished || excludedAccount,
            'Trading not started'
        );

        if (automatedMarketMakerPairs[recipient] && !excludedAccount) {
            require(amount <= maxSellTransactionAmount, 'Error amount');
        }

        if (automatedMarketMakerPairs[sender] && !excludedAccount) {
            require(amount <= maxBuyTransactionAmount, 'Buy Amount Exceeded!');
        }

        if (inSwap) {
            return _basicTransfer(sender, recipient, amount);
        }

        uint256 gonAmount = amount.mul(_gonsPerFragment);

        if (shouldSwapBack()) {
            swapBack();
        }

        _gonBalances[sender] = _gonBalances[sender].sub(gonAmount);
        if(_gonBalances[sender] == 0) {
            numberOfHolders--;
            holders[sender] = false;   
        }
        uint256 gonAmountReceived = shouldTakeFee(sender, recipient)
        ? takeFee(sender, recipient, gonAmount)
        : gonAmount;
        _gonBalances[recipient] = _gonBalances[recipient].add(
            gonAmountReceived
        );
        if(holders[recipient] == false) {
            numberOfHolders++;
            holders[recipient] = true;   
        }
        emit Transfer(
            sender,
            recipient,
            gonAmountReceived.div(_gonsPerFragment)
        );

        if (shouldRebase() && autoRebase) {
            _rebase();
        }
        // _update();

        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override validRecipient(to) returns (bool) {
        if (_allowedFragments[from][msg.sender] != ~uint256(0)) {
            _allowedFragments[from][msg.sender] = _allowedFragments[from][
            msg.sender
            ].sub(value, 'Insufficient Allowance');
        }

        _transferFrom(from, to, value);
        return true;
    }

    function lock(uint32 _days, uint256 _amount) public {
        // require(_days>=minExtraDays, "Lock: DAYS must be larger than MinExtraDays.");
        require(_days<=maxExtraDays, "Lock: DAYS must be small than MaxExtraDays.");
        require(_amount>=minExtraAmount, "Lock: Invalid amount.");
        // require(_amount<=maxExtraAmount, "Lock: Invalid amount.");
        LockInfo[] storage history = lockHistory[msg.sender];
        totalLocked += _amount;
        if(locking(msg.sender, true).length==0)
            totalLockedHolders++;
        history.push(LockInfo({
            locked: uint32(block.timestamp),
            unlocked: 0,
            duration: _days * 1 days,
            amount: _amount
        }));
        
        
        _basicTransfer(msg.sender, LOCK, _amount);
    }

    function unlock(uint32 _index) public {
        require(lockHistory[msg.sender].length>_index, "Unlock: Cannot find.");
        LockInfo storage info = lockHistory[msg.sender][_index];
        require(info.amount>0, "Unlock: Cannot find.");
        require(info.unlocked==0, "Unlock: Already unlocked.");
        // require(info.locked+info.duration<=block.timestamp, "Unlock: Pending.");
        info.unlocked = uint32(block.timestamp);
        uint256 duration = info.duration / 1 days;
        uint256 power = _powers[duration];
        uint256 one = 1 ether;
        if(power==0) {
            uint256 multiplier = one + one * duration * rewardExtra / rewardYieldDenominator;
            power = multiplier;
            for(uint i = 1;i<duration;i++) {
                power = power * multiplier / one;
            }
            power -= one;
            
            _powers[duration] = power;
        }
        
        uint256 extra = info.amount * power / one;
        totalLocked -= info.amount;
        totalRewarded += info.amount * power / one;
        if(locking(msg.sender, true).length==0)
            totalLockedHolders--;
        _basicTransfer(LOCK, msg.sender, info.amount + extra);
        // TOTAL_GONS += extra;
        // _gonBalances[msg.sender] += extra;
    }

    function locking(address _account, bool _pending) public view returns (LockInfo[] memory) {
        if(_pending) {
            uint256 count = 0;
            for(uint256 i = 0;i<lockHistory[_account].length;i++) {
                LockInfo storage info = lockHistory[_account][i];
                if(info.unlocked==0) count++;
            }
            LockInfo[] memory history = new LockInfo[](count);
            uint256 j = 0;
            for(uint256 i = 0;i<lockHistory[_account].length;i++) {
                LockInfo storage info = lockHistory[_account][i];
                if(info.unlocked==0) history[j++] = info;
            }
            return history;
        }
        return lockHistory[_account];
    }

    function _swapAndLiquify(uint256 contractTokenBalance) private {
        uint256 half = contractTokenBalance.div(2);
        uint256 otherHalf = contractTokenBalance.sub(half);

        uint256 initialBalance = address(this).balance;

        _swapTokensForETH(half, address(this));

        uint256 newBalance = address(this).balance.sub(initialBalance);

        _addLiquidity(otherHalf, newBalance);

        emit SwapAndLiquify(half, newBalance, otherHalf);
        
    }

    function _addLiquidity(uint256 tokenAmount, uint256 ETHAmount) private {
        router.addLiquidityETH{value: ETHAmount}(
            address(this),
            tokenAmount,
            0,
            0,
            liquidityReceiver,
            block.timestamp
        );
    }

    function _swapTokensForETH(uint256 tokenAmount, address receiver) private {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = router.WETH();

        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            receiver,
            block.timestamp
        );
    }

    function swapBack() internal swapping {
        uint256 realTotalFee = totalBuyFee.add(totalSellFee);

        uint256 dynamicLiquidityFee = isOverLiquified(
            targetLiquidity,
            targetLiquidityDenominator
        )
        ? 0
        : liquidityFee;
        uint256 contractTokenBalance = _gonBalances[address(this)].div(
            _gonsPerFragment
        );

        uint256 amountToLiquify = contractTokenBalance
        .mul(dynamicLiquidityFee.mul(2))
        .div(realTotalFee);

        uint256 amountToRFV = contractTokenBalance
        .mul(buyFeeRFV.mul(2).add(sellFeeRFVAdded))
        .div(realTotalFee);

        uint256 amountToTreasury = contractTokenBalance
        .sub(amountToLiquify)
        .sub(amountToRFV);

        if (amountToLiquify > 0) {
            _swapAndLiquify(amountToLiquify);
        }

        if (amountToRFV > 0) {
            _swapTokensForETH(amountToRFV, riskFreeValueReceiver);
        }

        if (amountToTreasury > 0) {
            _swapTokensForETH(amountToTreasury, treasuryReceiver);
        }

        emit SwapBack(
            contractTokenBalance,
            amountToLiquify,
            amountToRFV,
            amountToTreasury
        );
    }

    function manualSwapBack() external onlyOwner {
        uint256 realTotalFee = totalBuyFee.add(totalSellFee);

        uint256 dynamicLiquidityFee = isOverLiquified(
            targetLiquidity,
            targetLiquidityDenominator
        )
        ? 0
        : liquidityFee;
        uint256 contractTokenBalance = _gonBalances[address(this)].div(
            _gonsPerFragment
        );

        uint256 amountToLiquify = contractTokenBalance
        .mul(dynamicLiquidityFee.mul(2))
        .div(realTotalFee);

        uint256 amountToRFV = contractTokenBalance
        .mul(buyFeeRFV.mul(2).add(sellFeeRFVAdded))
        .div(realTotalFee);

        uint256 amountToTreasury = contractTokenBalance
        .sub(amountToLiquify)
        .sub(amountToRFV);

        if (amountToLiquify > 0) {
            _swapAndLiquify(amountToLiquify);
        }

        if (amountToRFV > 0) {
            _swapTokensForETH(amountToRFV, riskFreeValueReceiver);
        }

        if (amountToTreasury > 0) {
            _swapTokensForETH(amountToTreasury, treasuryReceiver);
        }

        emit SwapBack(
            contractTokenBalance,
            amountToLiquify,
            amountToRFV,
            amountToTreasury
        );
    }

    function takeFee( address sender, address recipient, uint256 gonAmount ) internal returns (uint256) {
        uint256 _realFee = totalBuyFee;
        uint256 _burnFee = burnFee;

        //check if it's a sell fee embedded
        if (automatedMarketMakerPairs[recipient]) {
            _realFee = totalSellFee;
            _burnFee = _burnFee.add(sellBurnFee);
        }

        uint256 feeAmount = gonAmount.mul(_realFee).div(feeDenominator);

        //make sure Burn is enabled and burnFee is > 0 (integer 0 equals to false)
        if (shouldBurn() && _burnFee > 0) {
            // burn the amount given % every transaction
            tokenBurner(
                (gonAmount.div(_gonsPerFragment)).mul(_burnFee).div(100)
            );
        }

        _gonBalances[address(this)] = _gonBalances[address(this)].add(
            feeAmount
        );
        emit Transfer(sender, address(this), feeAmount.div(_gonsPerFragment));

        return gonAmount.sub(feeAmount);
    }

    function tokenBurner(uint256 _tokenAmount) private {
        _transferFrom(address(this), address(DEAD), _tokenAmount);
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public override returns (bool) {
        uint256 oldValue = _allowedFragments[msg.sender][spender];
        if (subtractedValue >= oldValue) {
            _allowedFragments[msg.sender][spender] = 0;
        } else {
            _allowedFragments[msg.sender][spender] = oldValue.sub(
                subtractedValue
            );
        }
        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public override returns (bool) {
        _allowedFragments[msg.sender][spender] = _allowedFragments[msg.sender][
        spender
        ].add(addedValue);
        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    function approve(address spender, uint256 value) public override returns (bool) {

        _allowedFragments[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function _rebase() private {
        if (!inSwap) {
            uint256 circulatingSupply = getCirculatingSupply();
            int256 supplyDelta = int256(
                circulatingSupply.mul(rewardYield).div(rewardYieldDenominator)
            );

            coreRebase(supplyDelta);
        }
    }

    function coreRebase(int256 supplyDelta) private returns (uint256) {
        uint256 epoch = block.timestamp;

        if (supplyDelta == 0) {
            emit LogRebase(epoch, _totalSupply);
            return _totalSupply;
        }

        if (supplyDelta < 0) {
            _totalSupply = _totalSupply.sub(uint256(-supplyDelta));
        } else {
            _totalSupply = _totalSupply.add(uint256(supplyDelta));
        }

        if (_totalSupply > MAX_SUPPLY) {
            _totalSupply = MAX_SUPPLY;
        }

        _gonsPerFragment = TOTAL_GONS.div(_totalSupply);

        updateRebaseIndex(epoch);

        emit LogRebase(epoch, _totalSupply);
        return _totalSupply;
    }

    function manualRebase() external onlyOwner {
        require(!inSwap, 'Try again');
        require(nextRebase <= block.timestamp, 'Not in time');

        uint256 circulatingSupply = getCirculatingSupply();
        int256 supplyDelta = int256(
            circulatingSupply.mul(rewardYield).div(rewardYieldDenominator)
        );

        emit LogManualRebase(circulatingSupply, block.timestamp);
        coreRebase(supplyDelta);
    }

    function updateRebaseIndex(uint256 epoch) private {
        // update the next Rebase time
        nextRebase = epoch.add(rebaseFrequency);

        //update Index similarly to OHM, so a wrapped token created is possible (wGAMMA)

        //formula: rebaseIndex * (1 * 10 ** 18 + ((1 * 10 ** 18) + rewardYield / rewardYieldDenominator)) / 1 * 10 ** 18
        rebaseIndex = rebaseIndex
        .mul(
            oneEEighteen.add(
                oneEEighteen.mul(rewardYield).div(rewardYieldDenominator)
            )
        )
        .div(oneEEighteen);

        //simply show how often we rebased since inception (how many epochs)
        rebaseEpoch += 1;
    }

    function setAutomatedMarketMakerPair(address _pair, bool _value)
    public
    onlyOwner
    {
        require(
            automatedMarketMakerPairs[_pair] != _value,
            'Value already set'
        );

        automatedMarketMakerPairs[_pair] = _value;

        if (_value) {
            _markerPairs.push(_pair);
            _markerPairCount++;
        } else {
            require(_markerPairs.length > 1, 'Required 1 pair');
            for (uint256 i = 0; i < _markerPairs.length; i++) {
                if (_markerPairs[i] == _pair) {
                    _markerPairs[i] = _markerPairs[_markerPairs.length - 1];
                    _markerPairs.pop();
                    break;
                }
            }
        }

        emit SetAutomatedMarketMakerPair(_pair, _value);
    }

    function setInitialDistributionFinished(bool _value) external onlyOwner {
        require(initialDistributionFinished != _value, 'Not changed');
        initialDistributionFinished = _value;

        emit SetInitialDistribution(_value);
    }

    function setFeeExempt(address _addr, bool _value) external onlyOwner {
        require(_isFeeExempt[_addr] != _value, 'Not changed');
        _isFeeExempt[_addr] = _value;

        emit SetFeeExempt(_addr, _value);
    }

    function setTaxNonMarketMaker(bool _value) external onlyOwner {
        require(taxNonMarketMaker != _value, 'Not changed');
        taxNonMarketMaker = _value;
        emit TaxNonMarketMakerSet(_value, block.timestamp);
    }

    function setTargetLiquidity(uint256 target, uint256 accuracy)
    external
    onlyOwner
    {
        targetLiquidity = target;
        targetLiquidityDenominator = accuracy;
        emit SetTargetLiquidity(target, accuracy);
    }

    function setSwapBackSettings(
        bool _enabled,
        uint256 _num,
        uint256 _denom
    ) external onlyOwner {
        swapEnabled = _enabled;
        gonSwapThreshold = TOTAL_GONS.mul(_num).div(_denom);
        emit SetSwapBackSettings(_enabled, _num, _denom);
    }

    function setFeeReceivers(
        address _liquidityReceiver,
        address _treasuryReceiver,
        address _riskFreeValueReceiver
    ) external onlyOwner {
        require(_liquidityReceiver != address(0), '_liquidityReceiver not set');
        require(_treasuryReceiver != address(0), '_treasuryReceiver not set');
        require(
            _riskFreeValueReceiver != address(0),
            '_riskFreeValueReceiver not set'
        );
        liquidityReceiver = _liquidityReceiver;
        treasuryReceiver = _treasuryReceiver;
        riskFreeValueReceiver = _riskFreeValueReceiver;
        emit SetFeeReceivers(_liquidityReceiver, _treasuryReceiver, _riskFreeValueReceiver);
    }

    function setFees(
        uint256 _liquidityFee,
        uint256 _riskFreeValue,
        uint256 _treasuryFee,
        uint256 _burnFee,
        uint256 _sellFeeTreasuryAdded,
        uint256 _sellFeeRFVAdded,
        uint256 _sellBurnFee
    ) external onlyOwner {
        //check if total value does not exceed 20%
        uint256 maxTotalBuyFee = _liquidityFee.add(_treasuryFee).add(
            _riskFreeValue
        );

        uint256 maxTotalSellFee = maxTotalBuyFee.add(_sellFeeTreasuryAdded).add(
            _sellFeeRFVAdded
        );

        require(
            _liquidityFee <= MAX_FEE_RATE &&
            _riskFreeValue <= MAX_FEE_RATE &&
            _treasuryFee <= MAX_FEE_RATE &&
            _sellFeeTreasuryAdded <= MAX_FEE_RATE &&
            _sellFeeRFVAdded <= MAX_FEE_RATE,
            'set fee higher than max fee allowing'
        );

        require(maxTotalBuyFee < MAX_FEE_RATE, 'exceeded max buy fees');

        require(maxTotalSellFee < MAX_FEE_RATE, 'exceeded max sell fees');

        liquidityFee = _liquidityFee;
        buyFeeRFV = _riskFreeValue;
        treasuryFee = _treasuryFee;
        sellFeeTreasuryAdded = _sellFeeTreasuryAdded;
        sellFeeRFVAdded = _sellFeeRFVAdded;
        burnFee = _burnFee;
        sellBurnFee = _sellBurnFee;
        totalBuyFee = liquidityFee.add(treasuryFee).add(buyFeeRFV);

        setSellFee(
            totalBuyFee.add(sellFeeTreasuryAdded).add(sellFeeRFVAdded)
        );

        emit SetFees(_liquidityFee, _riskFreeValue, _treasuryFee, _sellFeeTreasuryAdded, _sellFeeRFVAdded, _burnFee, sellBurnFee, totalBuyFee);
    }

    function setSellFee(uint256 _sellFee) internal {
        totalSellFee = _sellFee;
    }

    function clearStuckBalance(address _receiver) external onlyOwner {
        require(_receiver != address(0x0), 'invalid address');
        uint256 balance = address(this).balance;
        payable(_receiver).transfer(balance);
        emit ClearStuckBalance(balance, _receiver, block.timestamp);

    }

    function rescueToken(address tokenAddress, uint256 tokens) external onlyOwner returns (bool success) {
        emit RescueToken(tokenAddress, msg.sender, tokens, block.timestamp);
        return IERC20(tokenAddress).transfer(msg.sender, tokens);
    }

    function setAutoRebase(bool _autoRebase) external onlyOwner {
        require(autoRebase != _autoRebase, 'Not changed');
        autoRebase = _autoRebase;
        emit SetAutoRebase(_autoRebase, block.timestamp);
    }

    //enable burn fee if necessary
    function setBurnFee(bool _isBurnEnabled) external onlyOwner {
        require(
            isBurnEnabled != _isBurnEnabled,
            "Burn function hasn't changed"
        );
        isBurnEnabled = _isBurnEnabled;
        emit SetBurnFee(_isBurnEnabled, block.timestamp);
    }

    function setRebaseFrequency(uint256 _rebaseFrequency) external onlyOwner {
        require(_rebaseFrequency <= MAX_REBASE_FREQUENCY, 'Too high');
        rebaseFrequency = _rebaseFrequency;
        emit SetRebaseFrequency(_rebaseFrequency, block.timestamp);
    }

    function setRewardYield(
        uint256 _rewardYield,
        uint256 _rewardYieldDenominator
    ) external onlyOwner {
        rewardYield = _rewardYield;
        rewardYieldDenominator = _rewardYieldDenominator;
        emit SetRewardYield(_rewardYield, _rewardYieldDenominator, block.timestamp);
    }

    function setFeesOnNormalTransfers(bool _enabled) external onlyOwner {
        require(feesOnNormalTransfers != _enabled, 'Not changed');
        feesOnNormalTransfers = _enabled;
        emit SetFeesOnNormalTransfers(_enabled, block.timestamp);
    }

    function setNextRebase(uint256 _nextRebase) external onlyOwner {
        require(
            _nextRebase > block.timestamp,
            'Next rebase can not be in the past'
        );
        nextRebase = _nextRebase;
        emit SetNextRebase(_nextRebase, block.timestamp);
    }

    function setMaxSellTransaction(uint256 _maxTxn) external onlyOwner {
        require(_maxTxn > MIN_SELL_AMOUNT_RATE, 'Below minimum sell amount');
        maxSellTransactionAmount = _maxTxn;
        emit SetMaxSellTransaction(_maxTxn, block.timestamp);
    }

    function setMaxBuyTransactionAmount(uint256 _maxTxn) external onlyOwner {
        require(_maxTxn > MIN_BUY_AMOUNT_RATE, 'Below minimum buy amount');
        maxBuyTransactionAmount = _maxTxn;
        emit SetMaxBuyTransactionAmount(_maxTxn, block.timestamp);
    }

    function setMinExtraDays(uint32 _minDays) external onlyOwner {
        minExtraDays = _minDays;
    }

    function setMaxExtraDays(uint32 _maxDays) external onlyOwner {
        maxExtraDays = _maxDays;
    }

    function setMinExtraAmount(uint32 _minAmount) external onlyOwner {
        minExtraAmount = _minAmount;
    }

    function setMaxExtraAmount(uint32 _maxAmount) external onlyOwner {
        maxExtraAmount = _maxAmount;
    }

    function getPriceFromPair() public view returns(uint256)
    {
        IDEXPair dexPair = IDEXPair(pair);
        (uint256 reserve0, uint256 reserve1,) = dexPair.getReserves();
        if(dexPair.token1()==address(this))
            (reserve0, reserve1) = (reserve1, reserve0);
        if(reserve0 > 0)
            return reserve1*1e18/reserve0;
        else 
            return 0;
    }    

    function withdrawCurrency(address currency) public onlyOwner() {
        if(currency==address(0))
            payable(msg.sender).transfer(address(this).balance);
        else
            IERC20(currency).transfer(msg.sender, IERC20(currency).balanceOf(address(this)));
    }

    
}