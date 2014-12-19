package com.inspur.cams.welfare.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.welfare.base.dao.IWealFitDeviceDao;
import com.inspur.cams.welfare.base.data.WealFitDevice;

/**
 * @title:WealFitDeviceDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public class WealFitDeviceDao extends EntityDao<WealFitDevice> implements IWealFitDeviceDao{

 	public WealFitDeviceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return WealFitDevice.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from WealFitDevice");
	}
   /**
	 * 假矫设施基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportDeviceInfo(ParameterSet pset) {
		 StringBuffer sql=new StringBuffer(); 
			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> argsList = new ArrayList<Object>();
	       String areaLevelId=(String)pset.getParameter("areaLevelId");
	       sql.append(" select d.id,d.Name,al.* from dic_city d left join( ");
		   sql.append("select ");
		   int index=12;
			if(StringUtils.isNotEmpty(areaLevelId)){
				index=getSubstrIndex(areaLevelId);
			}
		   sql.append(" rpad(substr(S.MORG_AREA,1,"+index+"),12,'0') MORG_AREA ,GET_CITYNAME(rpad(substr(S.MORG_AREA,1,"+index+"),12,'0') ) MORG_NAME,");
		   sql.append("  count(S.FIT_ID) AS NUM_SUM, ");
		   sql.append("  sum(case when F.DEVICE_CODE = '1' then F.DEVICE_NUM else 0 end) AS DEVICE_ONE , ");
	       sql.append("  sum(case when F.DEVICE_CODE = '2' then F.DEVICE_NUM else 0 end) AS DEVICE_TWO , ");
	       sql.append("  sum(case when F.DEVICE_CODE = '3' then F.DEVICE_NUM else 0 end) AS DEVICE_THREE , ");
	       sql.append("  sum(case when F.DEVICE_CODE = '4' then F.DEVICE_NUM else 0 end) AS DEVICE_FOUR , ");
	       sql.append("  sum(case when F.DEVICE_CODE = '5' then F.DEVICE_NUM else 0 end) AS DEVICE_FIVE , ");
	       sql.append("  sum(case when F.DEVICE_CODE = '6' then F.DEVICE_NUM else 0 end) AS DEVICE_SIX , ");
	       sql.append("  sum(case when F.DEVICE_CODE = '7' then F.DEVICE_NUM else 0 end) AS DEVICE_SEVEN  ");
	       
	       sql.append("  FROM weal_fit_device f, weal_fit_status s,weal_fit_apply p ");
	       sql.append(" WHERE 1=1");
	       sql.append(" AND s.task_code=p.task_code(+) ");
	       sql.append(" and p.task_code=f.task_code(+) ");
	       sql.append(" and s.status='1' ");
  	   
	       sql.append("group by rpad(substr(s.morg_area,1,").append(index).append("),12,'0') ,GET_CITYNAME(rpad(substr(s.morg_area,1,"+index+"),12,'0') )");
	       sql.append("  ) al on  al.MORG_AREA=d.id ");
	       sql.append("  where d.id = rpad(substr(d.id, 1, "+index+"), 12, 0) ");
	       if (StringUtils.isNotEmpty(areaLevelId)) {
	    	   if(areaLevelId.endsWith("000")){
			    	sql.append(" and d.ups=?  " );
			   } else {
			    	sql.append(" and d.id=?  " );
			   }
	    		typeList.add(Types.VARCHAR);
	      		argsList.add(areaLevelId);
	       }
	       sql.append(" order by d.id ");
	       DataSet ds=new DataSet();
	       if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sql.toString(), types, args,true);
			} else {
				ds = this.executeDataset(sql.toString(), true);
			}
			return ds;
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
