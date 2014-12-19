package com.inspur.cams.marry.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.bsp.share.organization.bean.PubOrganParms;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.marry.base.dao.IMrmGetOrganIdInfo;

/**
 * @author licb
 * @date:2011-12-5 下午12:06:51
 * @version :
 * MrmGetOrganIdInfo.java 
 */
 public class MrmGetOrganIdInfo extends EntityDao<PubOrganParms> implements IMrmGetOrganIdInfo{
	@Override
	protected Class getEntityClass() {
		return null;
	}
	 /**
	  * 根据organCode获取organId
	  * @param idCard
	  * @return
	  */
	public String checkOrganId(String organCode){
		StringBuffer sql=new StringBuffer();
		@SuppressWarnings("unused")
		List typeList = new ArrayList();
		@SuppressWarnings("unused")
		List<Object> argsList = new ArrayList();
		sql.append("SELECT p.organ_id ORGAN_ID FROM PUB_ORGAN p  WHERE p.organ_code= ? ");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{organCode});
		int num=list.size();
		if(num==0||list==null){
			return "0";
		}else{  
			String organId=(String)((Map)list.get(0)).get("ORGAN_ID");
			StringBuffer strBuf=new StringBuffer();
			strBuf.append(organId);
			strBuf.append("%");
		 
			return strBuf.toString();
		}
	}
}
