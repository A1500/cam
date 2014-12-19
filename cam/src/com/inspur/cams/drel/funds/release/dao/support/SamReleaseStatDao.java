package com.inspur.cams.drel.funds.release.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.ExportExcelPageUtil;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseStatDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseStat;

/**
 * @title:SamReleaseStatDao
 * @description:
 * @author:
 * @since:2012-06-11
 * @version:1.0
*/
 public class SamReleaseStatDao extends EntityDao<SamReleaseStat> implements ISamReleaseStatDao{

 	public SamReleaseStatDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamReleaseStat.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamReleaseStat");
	}

	public DataSet queryStatistics(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		
		argsList.add(pset.getParameter("statTime"));
		typeList.add(Types.VARCHAR);
		String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
		int index=12;
		if(StringUtils.isNotEmpty(domicileCode)){
			if(domicileCode.indexOf("000")<9&&domicileCode.indexOf("000")>0){
				//index=domicileCode.indexOf("000")+3;
				index=getSubstrIndex(domicileCode);
			}
		}
		sql.append("SELECT ");
		sql.append("  d.id,d.Name,al.* from dic_city d left join( ");
		sql.append("SELECT ");
		sql.append(" rpad(substr(R.RELEASE_AREA,1,"+index+"),12,'0') RELEASE_AREA_CODE,");
		sql.append(" GET_CITYNAME(rpad(substr(R.RELEASE_AREA,1,"+index+"),12,'0') ) RELEASE_AREA,");
		sql.append(" SUM(R.RELEASE_FAMILY_SUM) AS RELEASE_FAMILY_SUM,");
		sql.append(" SUM(R.CENTRAL_FAMILY_SUM) AS CENTRAL_FAMILY_SUM,");
		sql.append(" SUM(R.CENTRAL_CLASS_MON) AS CENTRAL_CLASS_MON,");
		sql.append(" SUM(R.PROVINCE_FAMILY_SUM) AS PROVINCE_FAMILY_SUM,");
		sql.append(" SUM(R.PROVINCE_CLASS_MON) AS PROVINCE_CLASS_MON,");
		sql.append(" SUM(R.CITY_FAMILY_SUM) AS CITY_FAMILY_SUM,");
		sql.append(" SUM(R.CITY_CLASS_MON) AS CITY_CLASS_MON,");
		sql.append(" SUM(R.COUNTY_FAMILY_SUM) AS COUNTY_FAMILY_SUM,");
		sql.append(" SUM(R.COUNTY_CLASS_MON) AS COUNTY_CLASS_MON,");
		sql.append(" SUM(R.ASSISTANCE_CLASS_MON_SUM) AS ASSISTANCE_CLASS_MON_SUM ");
		sql.append("  FROM SAM_RELEASE_STAT R");
		sql.append(" WHERE R.RELEASE_DATE = ? ");
		if(StringUtils.isNotEmpty(domicileCode)){
			sql.append("   AND R.RELEASE_AREA LIKE ? ");
			if(domicileCode.indexOf("000")!=-1){
				argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
			}else {
				argsList.add(domicileCode+"%");
			}
			typeList.add(Types.VARCHAR);
		}
		sql.append(" GROUP BY rpad(substr(R.RELEASE_AREA,1,"+index+"),12,'0') ,GET_CITYNAME(rpad(substr(R.RELEASE_AREA,1,"+index+"),12,'0') ) ");
	    sql.append("  ) al on  al.RELEASE_AREA_CODE=d.id ");
	    sql.append(" where d.id = rpad(substr(d.id, 1," +index+"), 12, 0)  " );
	    if(domicileCode.endsWith("000")){
	    	sql.append(" and d.ups=?  " );
	    } else {
	    	sql.append(" and d.id=?  " );
	    }
	    sql.append(" and is_self='0'  " );
   		argsList.add(domicileCode);
   		typeList.add(Types.VARCHAR);
	    sql.append(" order by d.id ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,  true);
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
	private int getSubstrIndex(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return 4;
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return 6;
		} else if (areaCode.endsWith("000000")){//县370104000000
			return 9;
		} else if (areaCode.endsWith("000")){//乡370104003000
			return 12;
		}
        return 12;
	}
}
