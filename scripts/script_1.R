library(forcats)
library(MASS)



# j'importe les données avec read_csv2 parce que c'est un csv avec des ; et que read_csv attend comme separateur des ,
df <- readr::read_csv(
  "RPindividus_24.csv",
  col_select = c(
    "REGION", "AGED", "ANAI", "CATL", "COUPLE",
    "SEXE", "SURF", "TP", "TRANS", "IPONDI"
  )
)


df |>
  group_by(AGED) |>
  summarise(n = sum(IPONDI))



ggplot(df) +
  geom_histogram(aes(x = 5 * floor(as.numeric(AGED) / 5), weight = IPONDI), stat = "count")

# correction (qu'il faudra retirer)
# ggplot(
#   df |> group_by(aged, sexe) |> summarise(SH_sexe = n()) |> group_by(aged) |> mutate(SH_sexe = SH_sexe/sum(SH_sexe)) |> filter(sexe==1)
# ) + geom_bar(aes(x = as.numeric(aged), y = SH_sexe), stat="identity") + geom_point(aes(x = as.numeric(aged), y = SH_sexe), stat="identity", color = "red") + coord_cartesian(c(0,100))

# stats trans par statut
df3 <- df |>
  group_by(COUPLE, TRANS) |>
  summarise(x = sum(IPONDI)) |>
  group_by(COUPLE) |>
  mutate(y = 100 * x / sum(x))

df <- df |>
  mutate(SEXE = as.character(SEXE)) |>
  mutate(SEXE = fct_recode(SEXE, Homme = "1", Femme = "2"))

p <- # part d'homme dans chaque cohort
  df |>
  group_by(AGED, SEXE) |>
  summarise(SH_sexe = sum(IPONDI)) |>
  group_by(AGED) |>
  mutate(SH_sexe = SH_sexe / sum(SH_sexe)) |>
  filter(SEXE == "Homme") |>
  ggplot() +
  geom_bar(aes(x = AGED, y = SH_sexe), stat = "identity") +
  geom_point(aes(x = AGED, y = SH_sexe), stat = "identity", color = "red") +
  coord_cartesian(c(0, 100))


ggsave("p.png", p)




# modelisation

df3 <- df |>
  filter(SURF != "Z") |>
  sample_n(1000)
df3 <- df3 |> mutate(SURF = factor(SURF, ordered = T))
df3 |>
  filter(COUPLE == 2 & between(AGED, 40, 60))
MASS::polr(SURF ~ factor(COUPLE) + factor(TP), df3)
