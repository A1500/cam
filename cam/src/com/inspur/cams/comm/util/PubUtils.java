package com.inspur.cams.comm.util;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.loushang.next.data.ParameterSet;

/**
 * @Path com.inspur.cams.fis.util.RecordToBeanUtil
 * @Description: TODO 一些公共方法
 * @author 李琪
 * @date 2011-11-30
 */
public class PubUtils {
	
	/**
	 * 判断字符串是否为空
	 * @param str
	 * @return 为空：true 不为空：false
	 */
	public static boolean isEmpty(String str) {
		boolean bl = false;
		if(str == null || "".equals(str) || "null".equals(str)) {
			bl = true;
		}
		return bl;
	}
	/**组织行政区划sql语句
	 * @param otherOrganCode  区划字段值
	 * @param organCodeFiled  区划字段名称
	 * @return 1:返回的区划2: 返回sql
	 */
	public static List<String> getOrganSql(String otherOrganCode ,String organCodeFiled){
		String organCode = BspUtil.getOrganCode();
		StringBuffer sql = new StringBuffer();
		List<String> list = new ArrayList<String>();
		if (otherOrganCode != null && !otherOrganCode.equals("")) {
			if (!otherOrganCode.substring(0, 2).equals("00")
					&& otherOrganCode.substring(2, 4).equals("00")) {// 省局
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,2)=?");
				list.add(otherOrganCode.substring(0, 2));
			} else if (!otherOrganCode.substring(2, 4).equals("00")
					&& otherOrganCode.substring(4).equals("00000000")) {// 市局
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,4)=?");
				list.add(otherOrganCode.substring(0, 4));
			} else if (!otherOrganCode.substring(4, 6).equals("00")
					&& otherOrganCode.substring(6, 9).equals("000")) {// 区县
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,6)=?");
				list.add(otherOrganCode.substring(0, 6));
			} else if (!otherOrganCode.substring(6, 9).equals("000")
					&& otherOrganCode.substring(9, 12).equals("000")) {// 街道
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,9)=?");
				list.add(otherOrganCode.substring(0, 9));
			} else {// 社区
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,12)=?");
				list.add(otherOrganCode);
			}
			
		} else {
			if (!organCode.substring(0, 2).equals("00")
					&& organCode.substring(2, 4).equals("00")) {// 省局
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,2)=?");
				list.add(organCode.substring(0, 2));
			} else if (!organCode.substring(2, 4).equals("00")
					&& organCode.substring(4, 6).equals("00")) {// 市局
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,4)=?");
				list.add(organCode.substring(0, 4));
			} else {// 区县
				sql.append(" AND SUBSTR(");
				sql.append(organCodeFiled);
				sql.append(" ,1,6)=?");
				list.add(organCode.substring(0, 6));
			}
		}
		list.add(sql.toString());
		return list;
	}
	
	/**
	 * 组装查询条件 获取int[]和Object[]
	 * @param sql 查询sql前半段
	 * @param pset 
	 * @param otherOrganCode 限制行政区划 null按organCode 
	 * @param otherOrganField 限制行政区划的字段  null则不限制 不填时otherOrganCode也可不填
	 * @param type 未使用此方法前的 int[] 没有则填null
	 * @param obj 未使用此方法前的 Object[] 没有则填null
	 * @return
	 */
	public static List<Object> queryUitl(StringBuffer sql ,ParameterSet pset,String otherOrganCode,String otherOrganField,int[] type,Object[] obj){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if(type!=null&&obj!=null){
			for(int i=0;i<typeList.size();i++){
				typeList.add(type[i]);
				argsList.add(obj[i]);
			}
		}
		if(otherOrganField!=null){
			List list = PubUtils.getOrganSql(otherOrganCode,otherOrganField);
			typeList.add(Types.VARCHAR);
			argsList.add(list.get(0));
			sql.append(list.get(1));
		}
		
		Set<String> set = pset.keySet();
		for(String key:set){//变量查询条件 组织查询语句
			if(key.contains("@")
					&&!"requiredOrganCode".equals(key)){
				String value = (String)pset.get(key);
				if (value != null && !value.equals("")) {
					String[] s= key.split("@");
					String[] s2 = value.split(",");
					
					if(key.toUpperCase().contains("OR@")){
						
						sql.append(" AND  (");
						for (int i = 0; i < s2.length; i++) {
							sql.append(s[1]);
							sql.append("  ");
							sql.append(s[2]);
							sql.append(" ? ");
							if(i<s2.length-1){
								sql.append(" or ");
							}
							typeList.add(Types.VARCHAR);
							if("LIKE".equals(s[2].toUpperCase())){
								s2[i]="%"+s2[i]+"%";
							}
							argsList.add(s2[i]);
						}
						sql.append(" ) ");
					}else{
						sql.append(" AND  ");
						key = key.replace('@', ' ');
						sql.append(key);
						sql.append("  ?");
						typeList.add(Types.VARCHAR);
						if("LIKE".equals(s[1].toUpperCase())){
							value="%"+value+"%";
						}
						argsList.add(value);
					}
				}
			}
			
		}
		
		int[] types=null;
		Object[] objs=null;
		if (typeList.size() != 0 && argsList.size() != 0) {
			types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			objs = argsList.toArray(new Object[argsList.size()]);
		}
		List<Object> objectList = new ArrayList<Object>();
		objectList.add(sql.toString());
		objectList.add(types);
		objectList.add(objs);
		return objectList;
	}
}	
