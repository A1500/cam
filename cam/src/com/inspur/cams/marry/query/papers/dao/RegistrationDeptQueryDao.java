package com.inspur.cams.marry.query.papers.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;
import java.sql.Types;
/**
 * 婚姻登记机关名册
 */
@SuppressWarnings("unchecked")
public class RegistrationDeptQueryDao extends BaseJdbcDao {

    public RegistrationDeptQueryDao() {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
    }
    public DataSet getDataSet(ParameterSet pset) {
        DataSet set = new DataSet();
        StringBuffer sql = new StringBuffer();
 		sql.append("SELECT INFO.NAME DEPTNAME,INFO.DEPT_ADDRESS ADDRESS,INFO.DEPT_POST DEPTPOST,INFO.ORGAN_ID,");
 		sql.append("INFO.DEPT_TEL DEPTTEL,INFO.MODIFY_ID,INFO.COMPLAIN_TEL,INFO.OFFICE_EMAIL,INFO.REGION_CODE,INFO.REGION_NAME,");
 		sql.append("INFO.TYPES,INFO.SSLEVEL,INFO.DEPT_CODE,INFO.CREAT_DATE,NVL(INFO.DEPT_NUM_RY,0) DEPT_NUM_RY,");
 		sql.append("NVL(INFO.DEPT_NUM_RDBZ,0) DEPT_NUM_RDBZ,NVL(INFO.DEPT_NUM_SJ,0) DEPT_NUM_SJ,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '01'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '02'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '03'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '04'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '05'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '06'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '07'),0)+");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '10'),0) TOTALAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '01'),0) HDAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '02'),0) JHAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '03'),0) LHAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '04'),0) BZAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '05'),0) ZXFDAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '06'),0) DASAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '07'),0) ZRSAREA,");
 		sql.append("NVL((SELECT T.FUNCTION_AREA FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '10'),0) QTAREA,");
 		sql.append("NVL((SELECT T.WINDOW_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '02'),0) +");
 		sql.append("NVL((SELECT T.WINDOW_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '03'),0) TOTALWIN,");
 		sql.append("NVL((SELECT T.WINDOW_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '02'),0) JHWIN,");
 		
 		sql.append("NVL((SELECT T.WINDOW_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '03'),0) LHWIN,");
 		sql.append("NVL((SELECT T.COMPUTER_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '02'),0) +");
 		sql.append("NVL((SELECT T.COMPUTER_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '03'),0) TOTALCOM,");
 		sql.append("NVL((SELECT T.COMPUTER_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '02'),0) JHCOM,");
 		sql.append("NVL((SELECT T.COMPUTER_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '03'),0) LHCOM,");
 		sql.append("NVL((SELECT T.CHAIR_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '01'),0) +");
 		sql.append("NVL((SELECT T.CHAIR_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '08'),0) +");
 		sql.append("NVL((SELECT T.CHAIR_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '04'),0) TOTALCHAIR,");
 		sql.append("NVL((SELECT T.CHAIR_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '01'),0) DHCHAIR,");
 		sql.append("NVL((SELECT T.CHAIR_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '08'),0) TBCHAIR,");
 		sql.append("NVL((SELECT T.CHAIR_NUM FROM MRM_REGIS_AREA T WHERE T.DEPT_ID  = INFO.DEPT_CODE AND T.FUNCTION_NAME = '04'),0) BZCHAIR,");
 		sql.append("INFO.SKIN_VALUE FROM MRM_REGIS_ORGAN_INFO INFO WHERE 1 ＝　1 ");
 		
 		String organCode = (String) pset.getParameter("xzqu");
 		String flag = (String) pset.getParameter("flag");
 		if(flag!=null&&!("".equals(flag))){
 			if(organCode!=null&&!("".equals(organCode))){
 				sql.append(" AND  INFO.DEPT_CODE LIKE ? ORDER BY INFO.DEPT_CODE ");
 				String code = organCode.substring(0,6)+"%";
 				if ("0000000000".equals(organCode.substring(2))) { // 省级
 					code = organCode.substring(0,2)+"%";
 				} else if ("00000000".equals(organCode.substring(4))) { // 市级
 					code = organCode.substring(0,4)+"%";
 				} else { // 县级
 					code = organCode.substring(0,6)+"%";
 				}
 				set = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR},new Object[]{code}, true);
 			}else{
 				set =this.executeDataset(sql.toString(),true);
 			}
 		}else{
 			if(organCode!=null&&!("".equals(organCode))){
 				sql.append(" AND  INFO.DEPT_CODE LIKE ? ORDER BY INFO.DEPT_CODE ");
 				String code = organCode.substring(0,6)+"%";
 				if ("0000000000".equals(organCode.substring(2))) { // 省级
 					code = organCode.substring(0,2)+"%";
 				} else if ("00000000".equals(organCode.substring(4))) { // 市级
 					code = organCode.substring(0,4)+"%";
 				} else { // 县级
 					code = organCode.substring(0,6)+"%";
 				}
 				set = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR},new Object[]{code},pset.getPageStart(),pset.getPageLimit(), true);
 			}else{
 				set =this.executeDataset(sql.toString(),pset.getPageLimit(),pset.getPageStart(),true);
 			}
 		}
        return set;
    }

    @Override
    protected void initDao() {

    }
}
