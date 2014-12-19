package com.inspur.sdmz.jtxx.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.jtxx.dao.IYgjzJtxxCyxxDao;
import com.inspur.sdmz.jtxx.data.BaseinfoPeople;

/**
 * @title:YgjzJtxxCyxxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public class YgjzJtxxCyxxDao extends EntityDao<BaseinfoPeople> implements IYgjzJtxxCyxxDao{

	 public DataSet itemQuery(ParameterSet pset,HttpServletRequest request) {
		 	DataSet resultDs = new DataSet();
		 	List typeList = new ArrayList();
			List<Object> argsList = new ArrayList();
		    String hzxm=(String)pset.getParameter("NAME");//户主姓名
		    StringBuffer organCode=new StringBuffer();
		    String organType="";
		    try{
		    	organType=ExtBspInfo.getUserInfo(request).getOrganType();
		    }catch (Exception e) {
		    	organCode.append(BspUtil.getCorpOrgan().getOrganCode());
			}
		    if(StringUtils.isNotEmpty(organType)){
		    	 organCode.append(ExtBspInfo.getUserInfo(request).getAreaCode());
		    }
			StringBuffer sql = new StringBuffer();
			sql.append("   select t.NAME as NAME ,t.FAMILY_ID as FAMILY_ID,t.ID_CARD as FAMILY_CARD_NO from BASEINFO_PEOPLE t,BASEINFO_FAMILY s");
			//修改说明，初期数据都未审核无法救助，特去除审核过滤条件，以后在设置。20110616  licb
			//sql.append("   where s.FAMILY_ID=t.FAMILY_ID and s.shbz='3'");

			 sql.append("   where s.FAMILY_ID=t.FAMILY_ID  ");
			String createOrgan="";
			String organCode2=organCode.toString();
			 if(organCode2.substring(2,12).equals("0000000000")){
					createOrgan=organCode2.substring(0,2);
				}else if(organCode2.substring(4,12).equals("00000000")){
					createOrgan=organCode2.substring(0,4);
				}else if(organCode2.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
					createOrgan=organCode2.substring(0,6);
				}else if(organCode2.substring(9,12).equals("000")){
					createOrgan=organCode2.substring(0,9);
				}else  {
					createOrgan=organCode2;
				}
			 sql.append("   and t.REG_ORG_AREA LIKE ?||'%'");
			 	typeList.add(Types.VARCHAR);
				argsList.add(createOrgan);
			 if(hzxm!=null && !"".equals(hzxm)) {
			   sql.append("   and t.NAME = ? ");
			   	typeList.add(Types.VARCHAR);
				argsList.add(hzxm);
			 }
			 if(typeList.size()!=0&&argsList.size()!=0){
					int[] types = new int[typeList.size()];
					for(int i=0;i<typeList.size();i++){
						types[i] = (Integer)typeList.get(i);
					}
					Object[] args = argsList.toArray(new Object[argsList.size()]);
					resultDs = this.executeDataset(sql.toString(),types,args,pset.getPageStart(), pset.getPageLimit(),true);
				}else{
					resultDs = this.executeDataset(sql.toString(),pset.getPageStart(), pset.getPageLimit(),true);
				}
				return resultDs;
		}

 	public YgjzJtxxCyxxDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}

	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  BASEINFO_PEOPLE where FAMILY_ID='" + fkId + "'");
	}

	public void batchDeleteByYgjzJtxx(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BASEINFO_PEOPLE where FAMILY_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	
	/**
	   * 根据身份证号码，查看人员已录入
	   */
	public String checkByIdCard(String idCard){
		StringBuffer sql=new StringBuffer();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		sql.append("SELECT p.FAMILY_ID FAMILY_ID,p.PHOTO_ID PHOTO_ID,p.REG_ORG_AREA REG_ORG_AREA,f.CUR_ACTIVITY CUR_ACTIVITY FROM BASEINFO_PEOPLE p,BASEINFO_FAMILY f   WHERE p.FAMILY_ID=f.FAMILY_ID AND p.ID_CARD= ? ");
		List list=this.executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{idCard});
		int num=list.size();
		if(num==0||list==null){
			return "0";
		}else{  
			String familyId=(String)((Map)list.get(0)).get("FAMILY_ID");
			String photoId=(String)((Map)list.get(0)).get("PHOTO_ID");
			String regOrgArea=(String)((Map)list.get(0)).get("REG_ORG_AREA");
			String curActivity=(String)((Map)list.get(0)).get("CUR_ACTIVITY");
			StringBuffer strBuf=new StringBuffer();
			strBuf.append(familyId);
			strBuf.append("%");
			strBuf.append(photoId);
			strBuf.append("%");
			strBuf.append(regOrgArea);
			strBuf.append("%");
			strBuf.append(curActivity);
			return strBuf.toString();
		}
	}
}
