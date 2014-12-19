package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.dicm.IDicDao;
import com.inspur.cams.sorg.base.dao.ISomChangeDao;
import com.inspur.cams.sorg.base.data.SomChange;

/**
 * 社会组织变更信息表dao实现
 * @author yanliangliang
 * @date 2011-7-13
 */
 public class SomChangeDao extends EntityDao<SomChange> implements ISomChangeDao{
	public static String QUERY_CHANGE_INFO = "SELECT A.CN_NAME,A.SORG_CODE,A.SORG_TYPE,B.CHANGE_ITEM,B.CHANGE_BEFORE,B.CHANGE_AFTER,C.AUDIT_TIME,A.IF_BRANCH FROM SOM_ORGAN_ONLINE A,SOM_CHANGE_ONLINE B ,SOM_APPLY_ONLINE C WHERE A.SORG_ID=B.SORG_ID AND B.TASK_CODE =C.TASK_CODE  AND C.IF_FINISH='1'";
  	@Override
	public Class<SomChange> getEntityClass() {
		return SomChange.class;
	}

	public void deleteChange(String id) {
		if(id != null && !("".equals(id.trim()))){
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM SOM_CHANGE WHERE ID= ?");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { id };
			executeUpdate(sql.toString(), types, args);
		}
		
	}
	 
	 /**
	  * 嵌入网站查询展示使用
	  * @param pset
	  * @return
	  */
	public DataSet queryChangeInfo(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(QUERY_CHANGE_INFO);
		String sorgCode=(String)pset.getParameter("SORG_CODE");
		String ifBranch = (String) pset.getParameter("IF_BRANCH");
		String cnName = (String) pset.getParameter("CN_NAME");
		String morgArea = (String) pset.getParameter("MORG_AREA");
		String sorgStatus = (String) pset.getParameter("SORG_STATUS");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		
		if(sorgCode != null && !sorgCode.equals("")){
			sql.append(" AND A.SORG_CODE=?");
			typeList.add(Types.VARCHAR);
			objList.add(sorgCode);
		}
		if(ifBranch != null && !ifBranch.equals("")){
			sql.append(" AND A.IF_BRANCH=?");
			typeList.add(Types.VARCHAR);
			objList.add(ifBranch);
		}
		if(cnName != null && !cnName.equals("")){
			sql.append(" AND A.CN_NAME=?");
			typeList.add(Types.VARCHAR);
			objList.add(cnName);
		}
		if(morgArea != null && !morgArea.equals("")){
			sql.append(" AND A.MORG_AREA=?");
			typeList.add(Types.VARCHAR);
			objList.add(morgArea);
		}
		if(sorgStatus != null && !sorgStatus.equals("")){
			sql.append(" AND A.SORG_STATUS=?");
			typeList.add(Types.VARCHAR);
			objList.add(sorgStatus);
		}
		
		sql.append( " ORDER BY C.AUDIT_TIME DESC NULLS LAST");
		DataSet ds = new DataSet();
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		int count = start+limit;
		if(typeList.size()!=0 && objList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int j = 0; j < typeList.size(); j++) {
				types[j]=typeList.get(j);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet ds0 = this.executeDataset(sql.toString(),types,objs,true);
			List<Record> list = ds0.getRecordSet();
			if(count>list.size()){
				count = list.size();
			}
			if(count == -2){
				start = 0;
				count= list.size();
			}
			for (int i = start; i < count; i++) {
				Record rd = (Record) list.get(i);
				String sorgTypeGet = (String)rd.get("SORG_TYPE");
				String ifBranchGet = (String)rd.get("IF_BRANCH");
				String changeItemGet = (String)rd.get("CHANGE_ITEM");
				String changeBefore = (String)rd.get("CHANGE_BEFORE");
				String changeAfter = (String)rd.get("CHANGE_AFTER");
				String changeBeforeFinal ="";
				String changeAfterFinal ="";
				//解析变更前和变更后项，去掉；
				if(sorgTypeGet.equals("S")){
					if(changeItemGet.equals("0")){
						rd.set("CHANGE_ITEM", "变更名称");
					}else if(changeItemGet.equals("1")){
						rd.set("CHANGE_ITEM", "变更住所");
					}else if(changeItemGet.equals("2")){
						rd.set("CHANGE_ITEM", "变更法定代表人");
					}else if(changeItemGet.equals("3")){
						rd.set("CHANGE_ITEM", "变更业务范围");
					}else if(changeItemGet.equals("4")){
						rd.set("CHANGE_ITEM", "变更注册资金");
					}else if(changeItemGet.equals("5")){
						rd.set("CHANGE_ITEM", "变更业务主管单位");
					}
					//主体的处理
					if(ifBranchGet.equals("0")){
						//变更名称
						if(changeItemGet.equals("0")){
							changeBeforeFinal = changeBefore.split(";",-1)[0];
							changeAfterFinal = changeAfter.split(";",-1)[0];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//变更住所
						if(changeItemGet.equals("1")){
							changeBeforeFinal = changeBefore.split(";",-1)[1];
							changeAfterFinal = changeAfter.split(";",-1)[1];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//法定代表人变更不需要处理
						//变更业务范围不需要处理
						//变更注册资金
						if(changeItemGet.equals("4")){
							changeBeforeFinal = changeBefore.split(";",-1)[1];
							changeAfterFinal = changeAfter.split(";",-1)[1];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//变更业务主管单位
						if(changeItemGet.equals("5")){
							IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
							changeBeforeFinal=dao.getTextValueFromDic("SOM_BUSINESS_ORGAN","BORG_CODE",changeBefore,"BORG_NAME");
							changeAfterFinal=dao.getTextValueFromDic("SOM_BUSINESS_ORGAN","BORG_CODE",changeAfter,"BORG_NAME");
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
					}
					//分支的处理
					if(ifBranchGet.equals("1")){
						//变更名称
						if(changeItemGet.equals("0")){
							changeBeforeFinal = changeBefore.split(";",-1)[0];
							changeAfterFinal = changeAfter.split(";",-1)[0];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//变更住所
						if(changeItemGet.equals("1")){
							changeBeforeFinal = changeBefore.split(";",-1)[1];
							changeAfterFinal = changeAfter.split(";",-1)[1];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//负责人变更
						if(changeItemGet.equals("2")){
							rd.set("CHANGE_ITEM", "变更负责人");
						}
						//变更业务范围不需要处理
						//变更注册资金
					}
				}
				if(sorgTypeGet.equals("M")){
					//主体的处理
					if(ifBranchGet.equals("0")){
						//变更名称
						//变更住所
						if(changeItemGet.equals("1")){
							changeBeforeFinal = changeBefore.split(";",-1)[1];
							changeAfterFinal = changeAfter.split(";",-1)[1];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//法定代表人变更不需要处理
						//变更业务范围不需要处理
						//变更开办资金
						if(changeItemGet.equals("4")){
							changeBeforeFinal = changeBefore.split(";",-1)[1];
							changeAfterFinal = changeAfter.split(";",-1)[1];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
					}
					//民非主体和分支的变更事项是一样的，统一处理
					if(changeItemGet.equals("0")){
						rd.set("CHANGE_ITEM", "变更名称");
					}else if(changeItemGet.equals("1")){
						rd.set("CHANGE_ITEM", "变更住所");
					}else if(changeItemGet.equals("2")){
						rd.set("CHANGE_ITEM", "变更法定代表人");
					}else if(changeItemGet.equals("3")){
						rd.set("CHANGE_ITEM", "变更业务范围");
					}else if(changeItemGet.equals("4")){
						rd.set("CHANGE_ITEM", "变更开办资金");
					}else if(changeItemGet.equals("5")){
						rd.set("CHANGE_ITEM", "变更业务主管单位");
					}
				}
				if(sorgTypeGet.equals("J")){
					if(changeItemGet.equals("0")){
						rd.set("CHANGE_ITEM", "变更名称");
					}else if(changeItemGet.equals("1")){
						rd.set("CHANGE_ITEM", "变更住所");
					}else if(changeItemGet.equals("2")){
						rd.set("CHANGE_ITEM", "变更法定代表人");
					}else if(changeItemGet.equals("3")){
						rd.set("CHANGE_ITEM", "变更业务范围");
					}else if(changeItemGet.equals("4")){
						rd.set("CHANGE_ITEM", "变更原始基金数额");
					}else if(changeItemGet.equals("5")){
						rd.set("CHANGE_ITEM", "变更宗旨");
					}else if(changeItemGet.equals("6")){
						rd.set("CHANGE_ITEM", "变更类型");
					}
					//主体的处理
					if(ifBranchGet.equals("0")){
						//变更名称
						//变更住所
						//法定代表人变更不需要处理
						//变更业务范围不需要处理
						//变更原始基金数额
						if(changeItemGet.equals("4")){
							changeBeforeFinal = changeBefore.split(";",-1)[1];
							changeAfterFinal = changeAfter.split(";",-1)[1];
							rd.set("CHANGE_BEFORE",changeBeforeFinal);
							rd.set("CHANGE_AFTER",changeAfterFinal);
						}
						//变更宗旨
						//变更类型
						if(changeItemGet.equals("6")){
							if(changeBefore.equals("1")){
								rd.set("CHANGE_BEFORE","公募");
							}
							if(changeBefore.equals("2")){
								rd.set("CHANGE_BEFORE","非公募");
							}
							if(changeAfter.equals("1")){
								rd.set("CHANGE_AFTER","公募");
							}
							if(changeAfter.equals("2")){
								rd.set("CHANGE_AFTER","非公募");
							}
						}
					}
					//分支的处理
					if(ifBranchGet.equals("1")){
						//变更负责人
						if(changeItemGet.equals("2")){
							rd.set("CHANGE_ITEM", "变更负责人");
						}
					}
				}
				ds.addRecord(rd);
			}
			ds.setTotalCount(list.size());
		}
		return ds;
	}
	 
	public void deleteChangeByTaskCode(String taskCode){
		if(taskCode != null && !("".equals(taskCode.trim()))){
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM SOM_CHANGE WHERE TASK_CODE = ?");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { taskCode };
			executeUpdate(sql.toString(), types, args);
		}
	}
   
}
