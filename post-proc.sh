#!/bin/bash
#SBATCH -J post-proc
#SBATCH -n 1
#SBATCH --ntasks-per-node=1
#SBATCH -p dav
#SBATCH -A NCGD0011
#SBATCH -t 24:00:00
#SBATCH --mem=1GB
#SBATCH -e %J.out
#SBATCH -o %J.out
if [ -z $MODULEPATH_ROOT ]; then
  unset MODULEPATH_ROOT
else
  echo "NO MODULEPATH_ROOT TO RESET"
fi
if [ -z $MODULEPATH ]; then
  unset MODULEPATH
else
  echo "NO MODULEPATH TO RESET"
fi
if [ -z $LMOD_SYSTEM_DEFAULT_MODULES ]; then
  unset LMOD_SYSTEM_DEFAULT_MODULES
else
  echo "NO LMOD_SYSTEM_DEFAULT_MODULES TO RESET"
fi
source /etc/profile
export TERM=xterm-256color
export HOME=/glade/u/home/mclong
unset LD_LIBRARY_PATH
export PATH=/glade/work/mclong/miniconda3/bin:$PATH
export PYTHONUNBUFFERED=False
export TMPDIR=/glade/scratch/mclong/tmp
module load nco
module list
source activate analysis

campaign_path=/glade/p/datashare/mclong/hi-res-eco/macro-algae

CASE=g.e11.G.T62_t12.eco.006
ARGS="--components ocn --campaign-path ${campaign_path}"
ARGS="${ARGS} --year-groups 1:1,2:2,3:3,4:4,5:5"
ARGS="${ARGS} --only-variables TEMP,SALT,HMXL,diazChl,diatChl,spChl,diatC,diazC,spC,zooC,DIA_IMPVF_NO3,HDIFE_NO3,HDIFN_NO3,J_NO3,KPP_SRC_NO3,NO3,UE_NO3,VN_NO3,WT_NO3,photoC_NO3_diat,photoC_NO3_sp,photoC_NO3_diaz,photoC_sp,photoC_diat,photoC_NO3_diaz"
ARGS="${ARGS} --only-streams pop.h"
ARGS="${ARGS} --archive-root /glade/campaign/cesm/development/bgcwg/projects/hi-res_CESM1_CORE"
DEMO= #"--demo"
/glade/u/home/mclong/p/macro-algae/misc-tools/cesm_hist2tseries.py ${ARGS} ${DEMO} ${CASE}
