package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.cdc.base.dao.ICdcPicInfoDao;
import com.inspur.cams.cdc.base.data.CdcPicInfo;

/**
 * 社区图片展示dao实现类
 * @author shgtch
 * @date 2012-2-7
 */
public class CdcPicInfoDao extends EntityDao<CdcPicInfo> implements ICdcPicInfoDao {
	
	@Override
	public Class<CdcPicInfo> getEntityClass() {
		return CdcPicInfo.class;
	}
	
	//查询社区建设展示
	public DataSet queryPicInfo(ParameterSet pset){
		String organCode = (String) pset.getParameter("organCode");
		String createTime = (String) pset.getParameter("createTime");
		String code = (String) pset.getParameter("ORGAN_CODE");
		StringBuffer sqlPic = new StringBuffer("SELECT T.ID,T.CONTENT,T.NOTE,T.ORGAN_CODE,T.ORGAN_NAME,T.CREATE_TIME ");
		sqlPic.append(" FROM CDC_PIC_INFO T WHERE 1 = 1 ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if (organCode != null && !organCode.equals("")) {
			sqlPic.append(" AND T.ORGAN_CODE  LIKE ''||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if (code != null && !code.equals("")) {
			sqlPic.append(" AND T.ORGAN_CODE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(code);
		}
		if (createTime != null && !"".equals(createTime)) {
			sqlPic.append(" AND T.CREATE_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(createTime);
		}
		
		sqlPic.append(" ORDER BY T.CREATE_TIME DESC");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sqlPic.toString(), types, args, pset
						.getPageStart(), pset.getPageLimit(), true);
		}else {
			ds = this.executeDataset(sqlPic.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
	}

}