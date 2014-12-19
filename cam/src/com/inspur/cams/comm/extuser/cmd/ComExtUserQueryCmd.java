package com.inspur.cams.comm.extuser.cmd;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;

/**
 * 外部单位用户查询cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtUserQueryCmd extends BaseQueryCommand {

	// 外部单位用户domain
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	
	/**
	 * 查询外部用户
	 * @return
	 */
	public DataSet execute() {
		return comExtUserDomain.queryExtUser(getParameterSet());
	}

	/**
	 * 根据行政区划查询外部用户
	 * @return
	 */
	public DataSet queryUser() {
		ParameterSet ps = getParameterSet();
		String organId = (String) ps.getParameter("organId");
		ParameterSet search = new ParameterSet();
		search.setParameter("ORGAN_ID@=", organId);
		search.setParameter("IN_USE@=", "1");
		return comExtUserDomain.queryExtUser(search);
	}
	
	/**
	 * 根据行政区划查询外部用户
	 * @return
	 */
	public DataSet queryUserNode() {
		ParameterSet ps = getParameterSet();
		//String organId = (String) ps.getParameter("organId");
		String id = (String) ps.getParameter("id");
		ParameterSet search = new ParameterSet();
		search.setParameter("ORGAN_ID@=", id);
		search.setParameter("IN_USE@=", "1");
		return comExtUserDomain.queryExtUser(search);
	}
	
	/**
	 * 获取城市用户
	 * 基层民主与社区建设使用
	 * @return
	 */
	public DataSet getChengShiUser() {
		ParameterSet ps = getParameterSet();
		String organId = (String) ps.getParameter("organId");
		String type = (String) ps.getParameter("type");
		ParameterSet search = new ParameterSet();
		search.setParameter("ORGAN_ID@=", organId);
		search.setParameter("COMMUNITY_TYPE@in", "T,C");
		search.setSortField("USER_ID");
		DataSet returnDataSet = comExtUserDomain.queryExtUser(search);
		if(type !=null){
			 DicCityDao dao = (DicCityDao) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			 ParameterSet pSet = new ParameterSet();
			 pSet.setParameter("UPS@=", organId);
			 pSet.setParameter("IS_SELF@=", "1");
			 DataSet ds = dao.query(pSet);
			 if(ds.getCount()>0){
				 Record record = ds.getRecord(0);
				 Record user = new Record();
				 user.set("userId", record.get("id"));
				 user.set("userName", record.get("name"));
				 user.set("areaCode", record.get("id"));
				 user.set("organId", record.get("ups"));
				 returnDataSet.getRecordSet().add(user); 
			 }
		}
		return returnDataSet;
	}
	
	/**
	 * 获取农村用户
	 * 基层民主与社区建设使用
	 * @return
	 */
	public DataSet getNongCunUser() {
		DataSet returnDataSet = new DataSet();
		ParameterSet ps = getParameterSet();
		String organId = (String) ps.getParameter("organId");
		String type = (String) ps.getParameter("type");
		ParameterSet search = new ParameterSet();
		search.setParameter("ORGAN_ID@=", organId);
		search.setParameter("COMMUNITY_TYPE@in", "T,N");
		search.setSortField("USER_ID");
		DataSet tempDataSet = comExtUserDomain.queryExtUser(search);
		int recordLength = tempDataSet.getCount();
		String belongs = "";
		Map<String, ComExtUser> resultMap = new HashMap<String, ComExtUser>();
		List<ComExtUser> userList = new ArrayList<ComExtUser>();
		ComExtUser tempUser = null;
		for(int i = 0;i<recordLength;i++){
			String currentBelongs = (String) tempDataSet.getRecord(i).get("communityBelongs");
			if(!belongs.equals(currentBelongs)){
				tempUser = getBelons(currentBelongs,tempDataSet);
				if(tempUser!=null){
					resultMap.put(currentBelongs,tempUser);
				}
				belongs = currentBelongs;
			}
		}
		for(ComExtUser user : resultMap.values()){
			userList.add(user);
		}
		if(type !=null){//添加本级
			 DicCityDao dao = (DicCityDao) DaoFactory
			.getDao("com.inspur.cams.comm.diccity.dao.jdbc.DicCityDao");
			 ParameterSet pSet = new ParameterSet();
			 pSet.setParameter("UPS@=", organId);
			 pSet.setParameter("IS_SELF@=", "1");
			 DataSet ds = dao.query(pSet);
			 if(ds.getCount()>0){
				 Record record = ds.getRecord(0);
				 Record user = new Record();
				 user.set("userId", record.get("id"));
				 user.set("areaCode", record.get("id"));
				 user.set("userName", record.get("name"));
				 user.set("organId", record.get("ups"));
				 userList.add((ComExtUser)user.toBean(ComExtUser.class));
			 }
		}
		Collections.sort(userList,new Comparator<ComExtUser>(){
			public int compare(ComExtUser user, ComExtUser otherUser) {
				return user.getUserId().compareTo(otherUser.getUserId());
			}
			
		});
		for(ComExtUser user : userList){
			returnDataSet.addRecord(user);
		}
		return returnDataSet;
	}

	/**
	 * 获取下辖村，如果没有则返回本社区
	 */
	public DataSet getXiaXiaCun(){
		DataSet returnDataSet = new DataSet();
		String organId = (String) getParameter("organCode");
		ParameterSet search = new ParameterSet();
		search.setParameter("USER_ID@=", organId);
		DataSet tempDataSet = comExtUserDomain.queryExtUser(search);
		returnDataSet = tempDataSet;
		if(tempDataSet.getCount()>0){
			Record record = tempDataSet.getRecord(0);
			if("1".equals(record.get("ifVillage"))){
				search.clear();
				search.setParameter("COMMUNITY_BELONGS@=", organId);
				search.setSortField("USER_ID");
				returnDataSet = comExtUserDomain.queryExtUser(search); 
			}
		}
		return returnDataSet;
	}
	/**
	 * 查找本村所属社区
	 * @param currentBelongs
	 * @param list
	 * @return
	 */
	private ComExtUser getBelons(String currentBelongs,DataSet list) {
		for(int i = 0;i<list.getCount();i++){
			ComExtUser user = (ComExtUser) list.getRecord(i).toBean(ComExtUser.class);
			if(currentBelongs.equals(user.getUserId())){
				return user;
			}
		}
		return null;
	}
}
