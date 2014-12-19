package com.inspur.cams.marry.analysis.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.marry.analysis.dao.IMarryAnalysisDao;
import com.inspur.cams.comm.print.dao.jdbc.intoMigrationPrintDao;
import com.inspur.cams.comm.util.BspUtil;

@SuppressWarnings("unchecked")
public class MarryAnalysisDao extends BaseJdbcDao implements IMarryAnalysisDao{

    public MarryAnalysisDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }


    /**
     * 婚姻统计查询
     * @param pset
     * @return
     */
	public DataSet analysisMarry(ParameterSet pset) {
		DataSet resultDs = new DataSet();
        StringBuffer sql = new StringBuffer();
        List typeList = new ArrayList();
	    List<Object> argsList = new ArrayList();
		//当前登陆人单位区划
		String organCode = BspUtil.getCorpOrgan().getOrganCode();//行政区划
		String substrOrgan=organCode;
		if(organCode.substring(2,12).equals("0000000000")){
			substrOrgan=organCode.substring(0,2);
		}else if(organCode.substring(4,12).equals("00000000")){
			substrOrgan=organCode.substring(0,4);
		}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
			substrOrgan=organCode.substring(0,6);
		}else if(organCode.substring(9,12).equals("000")){
			substrOrgan=organCode.substring(0,9);
		}else  {
			substrOrgan=organCode;
		} 
		sql.append("SELECT  SUM_DATE ,SUM(MARRY_NUM) AS MARRY_NUM,SUM(DIVORCE_NUM) AS DIVORCE_NUM FROM( ");
		
		//查询结婚量
		sql.append("SELECT A.SUM_DATE AS SUM_DATE,A.CITY_CODE, A.MARRY_NUM AS MARRY_NUM,0 DIVORCE_NUM ");
		sql.append("FROM MRM_BI_MARRY_MONTH_REAL A WHERE 1=1 ");
		sql.append("AND A.SUM_DATE >= TO_CHAR(SYSDATE - INTERVAL '6' MONTH, 'YYYY-MM') ");
		sql.append("AND A.SUM_DATE <TO_CHAR(SYSDATE, 'YYYY-MM') ");
		sql.append("AND A.CITY_CODE LIKE ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(substrOrgan+"%");
		sql.append("UNION ALL ");
		//查询离婚量
		sql.append("SELECT B.SUM_DATE AS SUM_DATE,B.CITY_CODE, 0 MARRY_NUM,B.MARRY_NUM AS DIVORCE_NUM ");
		sql.append("FROM MRM_BI_DIVORCE_MONTH_REAL B WHERE 1=1 ");
		sql.append(" AND B.SUM_DATE >= TO_CHAR(SYSDATE - INTERVAL '6' MONTH, 'YYYY-MM') ");
		sql.append("AND B.SUM_DATE <TO_CHAR(SYSDATE, 'YYYY-MM') ");
		sql.append("AND B.CITY_CODE LIKE ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(substrOrgan+"%");
		sql.append(") GROUP BY SUM_DATE ORDER BY SUM_DATE ");
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(),types,args,true);
		}else{
			resultDs = this.executeDataset(sql.toString(),true);
		}
		return resultDs;
	}
    @Override
    protected void initDao() {

    }
    public DataSet totalMarriageStatistics(ParameterSet pset) {
		DataSet resultDs = new DataSet();
        StringBuffer sql = new StringBuffer();
        List typeList = new ArrayList();
	    List<Object> argsList = new ArrayList();
		//当前登陆人单位区划
		String organCode = BspUtil.getCorpOrgan().getOrganCode();//行政区划
		String substrOrgan=organCode;
		int substrPos = 4;
		if(organCode.substring(2,12).equals("0000000000")){
			substrOrgan=organCode.substring(0,2);
			substrPos = 4;
		}else if(organCode.substring(4,12).equals("00000000")){
			substrOrgan=organCode.substring(0,4);
			substrPos = 6;
		}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
			substrOrgan=organCode.substring(0,6);
			substrPos = 9;
		}else if(organCode.substring(9,12).equals("000")){
			substrOrgan=organCode.substring(0,9);
			substrPos = 12;
		}else  {
			substrOrgan=organCode;
			substrPos = 12;
		} 
		sql.append("SELECT S.CITY_CODE CODE,C.NAME NAME, SUM(S.MARRY_NUM) AS MARRY_NUM, SUM(S.DIVORCE_NUM) AS DIVORCE_NUM FROM ( ");
		
		//查询结婚量
		sql.append("SELECT A.SUM_DATE AS SUM_DATE,RPAD(SUBSTR(A.CITY_CODE, 1,?), 12, '0') CITY_CODE,");
		typeList.add(Types.VARCHAR);
		argsList.add(substrPos);
		sql.append("A.MARRY_NUM AS MARRY_NUM, 0 DIVORCE_NUM FROM MRM_BI_MARRY_MONTH_REAL A  WHERE 1 = 1 ");
		sql.append("AND A.SUM_DATE >= TO_CHAR(SYSDATE, 'YYYY') ");
		sql.append("AND A.CITY_CODE LIKE ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(substrOrgan+"%");
		sql.append("UNION ALL ");
		//查询离婚量
		sql.append("SELECT B.SUM_DATE AS SUM_DATE,RPAD(SUBSTR(B.CITY_CODE, 1, ?), 12, '0') CITY_CODE,");
		typeList.add(Types.VARCHAR);
		argsList.add(substrPos);
		sql.append("0 MARRY_NUM, B.MARRY_NUM AS DIVORCE_NUM FROM MRM_BI_DIVORCE_MONTH_REAL B WHERE 1 = 1 ");
		sql.append("AND B.SUM_DATE >= TO_CHAR(SYSDATE, 'YYYY') ");
		sql.append("AND B.CITY_CODE LIKE ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(substrOrgan+"%");
		sql.append(")S ,DIC_CITY C WHERE S.CITY_CODE = C.ID(+) GROUP BY S.CITY_CODE,C.NAME ORDER BY S.CITY_CODE ");
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(),types,args,true);
		}else{
			resultDs = this.executeDataset(sql.toString(),true);
		}
		return resultDs;
	}
 
}
