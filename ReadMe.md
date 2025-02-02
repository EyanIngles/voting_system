# Flashloan Development Notes

This folder will be used for flashloan development. The goal is to understand how **pools** are created, managed, and utilized for **swaps** or **flashloan** operations. Below are detailed notes on the process, including pool creation, relevant structures, and functions.

---

## **Step 1: Pool Creation & Utility Functions**

To utilize flashloans and swaps, pools must first be created and managed effectively. Below are key insights on how pools work within the Cetus protocol.

---

### **Order Processing**

- **OrderInfo**:  
  Created when an order is placed. It checks for matching existing orders to execute the desired swap. If a match is found, the swap enters the **Fill** process.

---

### **State Management**

The **State** struct manages:
- **Governance**
- **History**
- **Accounts**

It processes all requests by updating one or more of these components.

---

## **Smart Voting System Idea**

For added security against scams, consider implementing a **smart contract-based voting system**. The system can require **permission from token holders** for actions such as:

- Funding or withdrawing from a treasury or liquidity pool.
  
### **Proposed Rules:**
- Only one proposal can be active at a time.
- The current proposal must be finalized (accepted, rejected, or modified) before a new one can be created.
- Community voting decides the outcome of proposals.

---

## **Pool Creation (`create_pool_v2`)**

The **`create_pool_v2`** function is responsible for creating new pools with initial liquidity. Below is the function signature:

```move
public fun create_pool_v2<CoinTypeA, CoinTypeB>(
    _config: &GlobalConfig,
    _pools: &mut Pools,
    _tick_spacing: u32,
    _initialize_price: u128,
    _url: String,
    _tick_lower_idx: u32,
    _tick_upper_idx: u32,
    _coin_a: Coin<CoinTypeA>,
    _coin_b: Coin<CoinTypeB>,
    _metadata_a: &CoinMetadata<CoinTypeA>,
    _metadata_b: &CoinMetadata<CoinTypeB>,
    _fix_amount_a: bool,
    _clock: &Clock,
    _ctx: &mut TxContext
): (Position, Coin<CoinTypeA>, Coin<CoinTypeB>)
```

---

## **Pool Struct**

The **Pool** struct contains key information about each liquidity pool:

```move
struct Pool<phantom CoinTypeA, phantom CoinTypeB> has key, store {
    id: UID,
    coin_a: Balance<CoinTypeA>,
    coin_b: Balance<CoinTypeB>,
    tick_spacing: u32,
    fee_rate: u64,
    liquidity: u128,
    current_sqrt_price: u128,
    current_tick_index: I32,
    fee_growth_global_a: u128,
    fee_growth_global_b: u128,
    fee_protocol_coin_a: u64,
    fee_protocol_coin_b: u64,
    tick_manager: TickManager,
    rewarder_manager: RewarderManager,
    position_manager: PositionManager,
    is_pause: bool,
    index: u64,
    url: String
}
```

---

## **Pool Initialization (`new`)**

The `new` function initializes a new pool. This function is typically restricted to the **factory module**.

```move
public(friend) fun new<CoinTypeA, CoinTypeB>(
    _tick_spacing: u32,
    _init_sqrt_price: u128,
    _fee_rate: u64,
    _url: String,
    _index: u64,
    _clock: &Clock,
    _ctx: &mut TxContext
): Pool<CoinTypeA, CoinTypeB>
```

### **Parameter Descriptions:**
- **`tick_spacing`**:  
  Controls the density of price points. Smaller values allow for more precise price ranges but increase gas costs.
  
- **`init_sqrt_price`**:  
  The initial square root price for the pool. This simplifies price calculations within the protocol.

- **`fee_rate`**:  
  The pool's fee rate. It's expressed as a numerator with a denominator of `1,000,000`. For example, a fee rate of `1000` represents **0.1%** (1000 / 1,000,000).

- **`index`**:  
  Used for position tracking and display purposes within the pool.

---

## **Tick Management**

Ticks define the range within which liquidity is active. You must set **`tick_lower_idx`** and **`tick_upper_idx`** to define this range during pool creation.

### **Suggested Tick Values for Testing:**

1. **Tick Spacing (`tick_spacing`)**:  
   - Suggested values: `500` to `1000`.  
   - Higher values are used for volatile assets to prevent excessive gas usage from frequent price updates.

2. **Lower Tick (`tick_lower_idx`)**:  
   - Suggested values: `0` to `100`.  
   - This defines the lowest price point where liquidity remains active.

3. **Upper Tick (`tick_upper_idx`)**:  
   - Suggested values: `1000` to `10,000`.  
   - This defines the highest price point where liquidity remains active.

---

### **Example Usage**
```move
let tick_spacing = 500;
let tick_lower_idx = 0;       // Start of the range
let tick_upper_idx = 10_000;  // End of the range

let (position, remaining_coin_a, remaining_coin_b) = create_pool_with_liquidity(
    &mut pools,
    &global_config,
    tick_spacing,
    initialize_price,
    url,
    tick_lower_idx,
    tick_upper_idx,
    coin_a,
    coin_b,
    amount_a,
    amount_b,
    fix_amount_a,
    &clock,
    &mut ctx
);
```

---

## **Summary**

- The **`create_pool_v2`** function initializes a pool with liquidity and parameters like tick spacing, initial price, and fee rates.
- Ticks define where your liquidity is active within the pool.
- Setting appropriate tick values is crucial to maximizing fee earnings and maintaining active liquidity.
