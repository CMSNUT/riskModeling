
# riskModeling

<!-- badges: start -->
<!-- badges: end -->

## 项目初始化
### 1. 创建新项目
首先打开 RStudio，通过以下步骤创建新项目：

点击菜单栏的 File > New Project

- 选择 New Directory

- 选择 New Project

- 输入项目名称（如 riskModeling）

- 选择项目位置

- 点击 Create Project (不勾选 git 和 renv)

### 2. 初始化 renv 包管理
在 RStudio 的控制台中执行以下命令：

```r
# 安装 renv 包（如果尚未安装）
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# 初始化项目环境
renv::init()
```r
### 3. 依赖包安装
- 创建 setup.R 文件：
```r
# 设置清华镜像加速（国内用户）
options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor")

# 检查并安装BiocManager
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager", quiet = TRUE)

# 定义要安装的cran包列表
cran_pkgs <- c(
  "gert",
  "usethis",
  "targets", 
  "tarchetypes", 
  "tidyverse", 
  "data.table", 
  "readxl", 
  "openxlsx", 
  "ggpubr",
  "rmarkdown", 
  "knitr", 
  "bookdown",
  "remotes",
  "igraph"
)
new_cran_pkgs <- cran_pkgs[!cran_pkgs %in% installed.packages()[, "Package"]]
install.packages(
  cran_pkgs, 
  dependencies = TRUE, 
  quiet = TRUE, 
  verbose = FALSE
)

# 定义要安装的Bioconductor包列表
bioc_pkgs <- c(
)

new_bioc_pkgs <- bioc_pkgs[!bioc_pkgs %in% installed.packages()[, "Package"]]
BiocManager::install(
  new_bioc_pkgs,
  dependencies = TRUE,
  ask = FALSE,
  quiet = TRUE
)

# 生成锁文件
renv::snapshot() # 增加或修改安装包，生成1次锁文件
```
### 4. 使用 gert 初始化 Git 仓库：
- 初始化 Git 仓库
```r
# 初始化 Git 仓库
gert::git_init()
```
- 添加 .gitignore 文件
```
# 添加 .gitignore 文件
writeLines(c(
  "# R 环境",
  ".Rproj.user/",
  ".renv/",
  "renv/library/",
  ".Rhistory",
  ".RData",
  ".Ruserdata",
  "",
  "# 数据文件",
  "raw_data/",
  "data/",
  "# 输出文件",
  "output/",
  "reports/*.html",
  "reports/*.pdf",
  "",
  "# 日志文件",
  "logs/"
), ".gitignore")
```

- 创建README.md
```r
# 创建README.md（同时生成R项目所需的其他文件）
usethis::use_readme_md()
```
- 创建远程仓库，并首次推送
```r
# 添加所有文件并提交
gert::git_add(".")
gert::git_commit("Initial commit: Project setup with renv")

# 创建主分支
if (!"main" %in% gert::git_branch_list()$name) {
  gert::git_branch_create("main")
}

# 首次推送
usethis::use_github()  # 创建远程仓库，并推送
配置 targets 工作流 
```

## 项目配置

