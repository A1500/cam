package com.inspur.cams.sorg.adm.summary.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.sorg.base.data.SomApply;

public class SomSummaryQueryDao extends EntityDao<SomApply>{

	/**
	 * select CASE sorg_type WHEN 'S' THEN '社会团体' when 'M' then '民办非企业单位' when 'J' then '基金会' end as sorg_type,case c.name when '山东省' then '省本级' else c.name end as name,substr(c.id,0,6)as area,case b.num when b.num then b.num else 0 end as num from (
select substr(a.morg_area,0,6) as area,count(a.sorg_type) num,sorg_type from som_organ a where sorg_status='22' and if_branch='0' AND A.SORG_TYPE IN('S','M','J') group by a.sorg_type,substr(a.morg_area,0,6) order by substr(a.morg_area,0,6)) b,
dic_city c where c.leve in('0','1') and  b.area(+)=substr(c.id,0,6);
	 */
	public static String sorgNumQuerySql = "SELECT CASE SORG_TYPE WHEN 'S' THEN '社会团体' WHEN 'M' THEN '民办非企业单位' WHEN 'J' THEN '基金会' END AS SORG_TYPE,CASE C.NAME WHEN '山东省' THEN '省本级' ELSE C.NAME END AS NAME,SUBSTR(C.ID,0,4)AS AREA,CASE B.NUM WHEN B.NUM THEN B.NUM ELSE 0 END AS SUMCOUNT FROM (SELECT SUBSTR(A.MORG_AREA,0,4) AS AREA,COUNT(A.SORG_TYPE) NUM,SORG_TYPE FROM SOM_ORGAN A WHERE SORG_STATUS='22' AND IF_BRANCH='0' AND A.SORG_TYPE IN('S','M','J') GROUP BY A.SORG_TYPE,SUBSTR(A.MORG_AREA,0,4) ORDER BY SUBSTR(A.MORG_AREA,0,4)) B,DIC_CITY C WHERE C.LEVE IN('0','1') AND  B.AREA(+)=SUBSTR(C.ID,0,4) ORDER BY AREA,SORG_TYPE DESC";
  	@Override
	public Class<SomApply> getEntityClass() {
		return SomApply.class;
	}


	public DataSet querySorgNumGrid(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		DataSet ds = this.executeDataset(sorgNumQuerySql, true);
		return ds;
	}

	/**
	 * 查询某年某类社会组织数量
	 * @param areaCode
	 * @param year
	 * @return
	 */
	public DataSet querySorgYearNumGrid(String areaCode,String year,String sorgType) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(*) COUNTNUM FROM SOM_ORGAN A WHERE A.SORG_STATUS='22' AND A.SORG_TYPE='S' AND A.IF_BRANCH='0'");
		sql.append("AND MORG_AREA LIKE ? ");
		sql.append("AND REG_DATE LIKE ? ");
		sql.append("AND SORG_TYPE = ? ");
		typeList.add(Types.VARCHAR);
		objsList.add(areaCode+"%");
		typeList.add(Types.VARCHAR);
		objsList.add(year+"%");
		typeList.add(Types.VARCHAR);
		objsList.add(sorgType);
		DataSet ds = new DataSet();
		if(typeList.size()!=0 && objsList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int j = 0; j < typeList.size(); j++) {
				types[j]=typeList.get(j);
			}
			Object[] objs = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(),types,objs,true);
		}
		return ds;
	}

	public DataSet queryAddNumGrid(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objList = new ArrayList<String>();
		String areaCode = BspUtil.getOrganCode();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from (");
		sql.append("select substr(yearmonth,6,7) month,countNum from (");
		sql.append("select substr(a.reg_date,0,7) as yearmonth ,count(substr(a.reg_date,0,7)) as countNum from som_organ a where a.MORG_AREA like ? and a.if_branch='0' and a.sorg_status='22' and substr(a.reg_date,0,4)=to_char(sysdate,'yyyy') and length(substr(a.reg_date,0,7))=7 group by substr(a.reg_date,0,7) order by substr(a.reg_date,0,7)");
		sql.append("))e,(");
		sql.append("select * from (");
		sql.append(" select '01' as tmonth  from dual union all select '02' from dual union all select '03'  from dual union all");
		sql.append(" select '04'  from dual union all select '05' from dual union all select '06' from dual union all");
		sql.append(" select '07'  from dual union all select '08' from dual union all select '09'  from dual union all");
		sql.append(" select '10' from dual  union all select '11' from dual union all select '12'  from dual");
		sql.append(")");
		sql.append(") f  where e.month(+)=f.tmonth order by tmonth");
		typeList.add(Types.VARCHAR);
		if(areaCode.indexOf("000")!=-1){
			objList.add(getAreaCodeLikePrefix(areaCode)+"%");
		}else {
			objList.add(areaCode+"%");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objList.toArray(new Object[objList.size()]);
		DataSet ds = this.executeDataset(sql.toString(),types,args, true);
		return ds;
	}

	public DataSet queryCancelNumGrid(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objList = new ArrayList<String>();
		String areaCode = BspUtil.getOrganCode();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from (");
		sql.append("select substr(yearmonth,6,7) month,countNum from (");
		sql.append("select substr(a.CANCEL_DATE,0,7) as yearmonth ,count(substr(a.CANCEL_DATE,0,7)) as countNum from som_organ a where a.MORG_AREA like ? and a.if_branch='0' and a.sorg_status='32' and substr(a.CANCEL_DATE,0,4)=to_char(sysdate,'yyyy') and length(substr(a.CANCEL_DATE,0,7))=7 group by substr(a.CANCEL_DATE,0,7) order by substr(a.CANCEL_DATE,0,7)");
		sql.append("))e,(");
		sql.append("select * from (");
		sql.append(" select '01' as tmonth  from dual union all select '02' from dual union all select '03'  from dual union all");
		sql.append(" select '04'  from dual union all select '05' from dual union all select '06' from dual union all");
		sql.append(" select '07'  from dual union all select '08' from dual union all select '09'  from dual union all");
		sql.append(" select '10' from dual  union all select '11' from dual union all select '12'  from dual");
		sql.append(")");
		sql.append(") f  where e.month(+)=f.tmonth order by tmonth");
		typeList.add(Types.VARCHAR);
		if(areaCode.indexOf("000")!=-1){
			objList.add(getAreaCodeLikePrefix(areaCode)+"%");
		}else {
			objList.add(areaCode+"%");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objList.toArray(new Object[objList.size()]);
		DataSet ds = this.executeDataset(sql.toString(),types,args, true);
		return ds;
	}

	public DataSet querySorgKindPie(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objList = new ArrayList<String>();
		String areaCode = BspUtil.getOrganCode();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT SORG_KIND,COUNT(SORG_KIND) AS COUNT FROM SOM_ORGAN A WHERE A.SORG_TYPE='S' AND A.IF_BRANCH='0' AND A.SORG_STATUS='22' AND A.SORG_KIND IS NOT NULL AND A.MORG_AREA like ? GROUP BY A.SORG_KIND");
		typeList.add(Types.VARCHAR);
		if(areaCode.indexOf("000")!=-1){
			objList.add(getAreaCodeLikePrefix(areaCode)+"%");
		}else {
			objList.add(areaCode+"%");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objList.toArray(new Object[objList.size()]);
		DataSet ds = this.executeDataset(sql.toString(),types,args, true);
		return ds;
	}

	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}

}

