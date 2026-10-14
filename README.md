# King County House Sales: What Drives the Selling Price?

Exploratory data analysis (EDA) of house sales in King County (Seattle area, USA) between **May 2014 and May 2015**, with insights and recommendations for a **seller**.

## Client

**Charles Christensen (Seller)**: wants to invest with big returns and is wondering about **renovation**, the right **neighborhood** and the best **timing**.

The three insights below answer exactly these three questions: *should I renovate?*, *where?* and *when?*

## Key Insights

| # | Question | Hypothesis | Result |
|---|----------|------------|--------|
| 1 | Does renovation increase the price? | **H1:** Renovated houses sell for a higher price per sqft. | Renovated houses look **24% more expensive** per sqft overall, but **only ~2.5% more** when compared within the same zipcode. Most of the difference comes from location, not renovation. |
| 2 | Where in King County are houses more expensive? *(geographical)* | **H2:** The closer a house is to downtown Seattle, the higher its price per sqft. | **Supported.** Median price per sqft falls from **$369** (within 5 km of downtown) to **$168** (more than 30 km away), a drop of about **55%**. |
| 3 | When is the best time to sell? | **H3:** Houses sold in spring get a higher price per sqft than in winter. | **Supported.** Spring median **$253/sqft** vs. winter **$235/sqft** (**+7.7%**). Peak in **April (~$260)**, lowest in **December (~$233)**. Spring is also the busiest season (most sales in May). |

**Overall ranking of price drivers:** Location > Timing > Renovation.

## Recommendations

1. **Invest in the right location.** Location is by far the strongest price driver. Houses close to downtown Seattle and in premium zipcodes (e.g. around Lake Washington) achieve up to about **2.2× more per sqft**. Price the house based on comparable houses in the same area.
2. **Sell in spring (March to May).** Prices and buyer demand are highest then. Avoid listing in December or January.
3. **Only renovate when it is cheap.** Renovation adds only about **2–3%** to the price per sqft within the same area, so a full renovation rarely pays off. Small, inexpensive improvements are the better choice.

## Repository Structure

| File / Folder | Description |
|---------------|-------------|
| [**04_eda.ipynb**](04_eda.ipynb) | **Main notebook**: the full analysis with all three insights, charts, results and conclusions. Start here. |
| [**03_fetching_the_data_eda.ipynb**](03_fetching_the_data_eda.ipynb) | Connects to the PostgreSQL database, runs the SQL join and saves the data as `data/eda.csv`. |
| [**sql/king_county_join.sql**](sql/king_county_join.sql) | SQL query that joins the two database tables (house sales + house details). |
| [**column_names.md**](column_names.md) | Data dictionary: what each column means. |
| [**01_assignment.md**](01_assignment.md) | Original project brief, tasks and list of clients. |
| [**02_workflow.md**](02_workflow.md) | Recommended EDA workflow. |
| [**data/**](data/) | Location of the dataset (`eda.csv`). The data files are **not** pushed to GitHub. |
| [**.env.example**](.env.example) | Template for the database credentials. |
| [**pyproject.toml**](pyproject.toml) / [**uv.lock**](uv.lock) | Project dependencies. |

## Data

- **Source:** King County House Sales dataset, stored in the `eda` schema of the course PostgreSQL database (two tables: `king_county_house_sales` and `king_county_house_details`).
- **Join:** each sale is joined to its house details with `sales.house_id = details.id` (see [the SQL file](sql/king_county_join.sql)).
- **Size:** 21,597 sales, from 2 May 2014 to 27 May 2015.
- **Main columns used:** `price`, `sqft_living`, `yr_renovated`, `zipcode`, `lat`, `long`, `date`.

## Methodology

1. Loaded and checked the data (types, missing values, date conversion).
2. Created new features:
   - `price_per_sqft` = `price / sqft_living`, so that houses of different sizes can be compared fairly.
   - `renovated` = `True` if `yr_renovated` > 0.
   - `dist_downtown_km` = straight-line distance to downtown Seattle (47.6062, −122.3321), calculated with the haversine formula.
   - `month` and `season` from the sale date.
3. Compared **medians** between groups (renovated vs. not, distance bands, months, seasons). Medians are used because house prices contain extreme values.
4. Checked the renovation effect **within the same zipcode** to separate it from the location effect.

## Assumptions and Limitations

- `yr_renovated` = 0 or missing is treated as "never renovated". The data does not say *what* was renovated.
- Downtown Seattle is assumed to be at latitude 47.6062, longitude −122.3321. Distances are straight-line, not driving distances.
- Seasons: Winter = Dec–Feb, Spring = Mar–May, Summer = Jun–Aug, Fall = Sep–Nov.
- The data covers only about **one year**, so the seasonal pattern is one year's result, not a proven rule.
- The results show **relationships, not proof of cause and effect**.

## Setup

1. Clone the repository and install the dependencies (creates a `.venv/` folder):

   ```bash
   git clone <repo-url>
   cd <repo-name>
   uv sync
   ```

2. Copy `.env.example` to `.env` and fill in the database credentials:

   ```bash
   cp .env.example .env
   ```

3. Run [03_fetching_the_data_eda.ipynb](03_fetching_the_data_eda.ipynb) to download the data into `data/eda.csv`.
4. Open [04_eda.ipynb](04_eda.ipynb) in VS Code, select the `.venv` kernel and click **Run All**.

> [!CAUTION]
> `.env` contains passwords and must never be committed. It is already listed in `.gitignore`.

## Author

Maryam Sajedi, neuefische Data Science Bootcamp
