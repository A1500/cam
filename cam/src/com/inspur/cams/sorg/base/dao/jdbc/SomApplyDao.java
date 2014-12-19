package com.inspur.cams.sorg.base.dao.jdbc;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.dao.ISomApplyDao;
import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会组织业务dao实现类
 * @author shgtch
 * @date 2011-8-18
 */
public class SomApplyDao extends EntityDao<SomApply> implements ISomApplyDao{

  	@Override
	public Class<SomApply> getEntityClass() {
		return SomApply.class;
	}
  	
	public String queryProcessId(String id) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT PROCESS_ID FROM WF_END_TASK WHERE ID= ?");
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { id };
		List<Map<String, String>> list = executeQuery(sql.toString(), types, args);
		String processId = list.get(0).get("PROCESS_ID");
		return processId;

	}
	@SuppressWarnings("unchecked")
	public DataSet queryHisChange(ParameterSet params) {
		DataSet resultDs = new DataSet();
		StringBuffer sql = new StringBuffer();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String SORG_ID = (String) params.getParameter("SORG_ID");
		String SORG_TYPE = (String) params.getParameter("SORG_TYPE");
		String APPLY_TYPE = (String) params.getParameter("APPLY_TYPE");
		String ACCEPT_AREA = (String) params.getParameter("ACCEPT_AREA");
		String DATA_SOURCE = (String) params.getParameter("DATA_SOURCE");
		sql.append("SELECT T.SORG_ID,T.TASK_CODE,T.SORG_NAME,");
		sql.append("wmsys.wm_concat(S.CHANGE_ITEM) AS CHANGE_ITEMS,");
		sql.append("T.ACCEPT_ORGAN_NAME,T.ACCEPT_PEOPLE_NAME,T.ACCEPT_TIME");
		sql.append(" FROM SOM_APPLY T LEFT JOIN SOM_CHANGE S ON T.TASK_CODE = S.TASK_CODE ");
		sql.append(" WHERE 1 = 1 ");
		//查询条件 
		 if (SORG_ID != null && !"".equals(SORG_ID)) {
				sql.append(" and T.SORG_ID = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(SORG_ID);
			}
		 if (SORG_TYPE != null && !"".equals(SORG_TYPE)) {
				sql.append(" and T.SORG_TYPE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(SORG_TYPE);
			}
		 if (APPLY_TYPE != null && !"".equals(APPLY_TYPE)) {
				sql.append(" and T.APPLY_TYPE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(APPLY_TYPE);
			}
		 if (ACCEPT_AREA != null && !"".equals(ACCEPT_AREA)) {
				sql.append(" and T.ACCEPT_AREA = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(ACCEPT_AREA);
			}
		 if (DATA_SOURCE != null && !"".equals(DATA_SOURCE)) {
				sql.append(" and T.DATA_SOURCE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(DATA_SOURCE);
			}
		sql.append(" GROUP BY T.SORG_ID,T.TASK_CODE,T.SORG_NAME,T.ACCEPT_ORGAN_NAME,T.ACCEPT_PEOPLE_NAME, T.ACCEPT_TIME ");
		int start =getDsStart(params);
		int limit = getDsLimit(params);
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(sql.toString(),types,args,start,limit,true);
		}else{
			resultDs = this.executeDataset(sql.toString(),start,limit,true);
		}
		return resultDs;
	}
	public DataSet querySorgApply(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		boolean ifHasSearchCondition = false;
		String taskCode = (String)pset.getParameter("TASK_CODE");
		String sorgCode = (String)pset.getParameter("SORG_CODE");
		String sorgName = (String)pset.getParameter("SORG_NAME");
		String organCode = (String)pset.getParameter("ORGAN_CODE");
		String sorgType = (String)pset.getParameter("SORG_TYPE");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM SOM_APPLY A,SOM_ORGAN B WHERE ");
		sql.append(" A.APPLY_TYPE IN (");
		sql.append("'"+ApplyType.SOM_GROUP_NAME_APPROVAL+"',");
		sql.append("'"+ApplyType.SOM_FUND_NAME_APPROVAL+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_NAME_APPROVAL+"',");
		sql.append("'"+ApplyType.SOM_GROUP_NAME_APPROVAL+"',");
		sql.append("'"+ApplyType.SOM_GROUP_PREPARE+"',");
		sql.append("'"+ApplyType.SOM_GROUP_BUILD+"',");
		sql.append("'"+ApplyType.SOM_GROUP_CHANGE+"',");
		sql.append("'"+ApplyType.SOM_GROUP_CANCEL+"',");
		sql.append("'"+ApplyType.SOM_GROUP_BRANCH_BUILD+"',");
		sql.append("'"+ApplyType.SOM_GROUP_BRANCH_CHANGE+"',");
		sql.append("'"+ApplyType.SOM_GROUP_BRANCH_CANCEL+"',");
		sql.append("'"+ApplyType.SOM_GROUP_BRANCH_ANOTHER_PLACE_CHECK+"',");
		sql.append("'"+ApplyType.SOM_FUND_NAME_APPROVAL+"',");
		sql.append("'"+ApplyType.SOM_FUND_BUILD+"',");
		sql.append("'"+ApplyType.SOM_FUND_CHANGE+"',");
		sql.append("'"+ApplyType.SOM_FUND_CANCEL+"',");
		sql.append("'"+ApplyType.SOM_FUND_BRANCH_BUILD+"',");
		sql.append("'"+ApplyType.SOM_FUND_BRANCH_CHANGE+"',");
		sql.append("'"+ApplyType.SOM_FUND_BRANCH_CANCEL+"',");
		sql.append("'"+ApplyType.SOM_FUND_BRANCH_ANOTHER_PLACE_CHECK+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_NAME_APPROVAL+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_BUILD_LEGAL+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_CHANGE+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_CANCEL+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_PREPARE+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_BUILD_PARTNERSHIP+"',");
		sql.append("'"+ApplyType.SOM_UNGOV_BUILD_INDIVIDUAL+"')");
		if(taskCode != null&&!taskCode.equals("")){
			sql.append(" AND A.TASK_CODE = ?");
			typeList.add( Types.VARCHAR );
			objsList.add(taskCode);
			ifHasSearchCondition = true;
		}
		if(sorgCode != null&&!sorgCode.equals("")){
			sql.append(" AND B.SORG_CODE = ?");
			typeList.add( Types.VARCHAR );
			objsList.add(sorgCode);
			ifHasSearchCondition = true;
		}
		if(sorgName != null&&!sorgName.equals("")){
			sql.append(" AND B.CN_NAME = ?");
			typeList.add( Types.VARCHAR );
			objsList.add(sorgName);
			ifHasSearchCondition = true;
		}
		if(sorgType != null&&!sorgType.equals("")){
			sql.append(" AND A.SORG_TYPE = ?");
			typeList.add( Types.VARCHAR );
			objsList.add(sorgType);
		}
		if(ifHasSearchCondition){
			sql.append(" AND A.SORG_ID=B.SORG_ID ");
			sql.append(" AND A.ACCEPT_AREA LIKE ?");
			typeList.add( Types.VARCHAR );
			objsList.add(organCode.substring(0,6)+"%");
		}else{
			sql.append(" AND A.TASK_CODE = ?");
			typeList.add( Types.VARCHAR );
			objsList.add("NOT EXIST!");
		}
		sql.append(" ORDER BY A.ACCEPT_TIME ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
		List<Map<String, String>> list = executeQuery(sql.toString(),types,args);
		
		DataSet ds = new DataSet();
		for(int i = 0;i<list.size();i++){
			SomApply somapply = new SomApply();
			somapply.setTaskCode(list.get(i).get("TASK_CODE"));
			somapply.setSorgName(list.get(i).get("SORG_NAME"));
			String applyType = list.get(i).get("APPLY_TYPE");
			applyType = reflect(applyType);
			somapply.setApplyType(applyType);
			somapply.setIfFinish(list.get(i).get("IF_FINISH").equals("1")?"完成":"未完成");
			somapply.setAcceptPeopleName(list.get(i).get("ACCEPT_PEOPLE_NAME"));
			somapply.setAcceptTime(list.get(i).get("ACCEPT_TIME"));
			somapply.setAcceptDeptName(list.get(i).get("ACCEPT_DEPT_NAME"));
			ds.addRecord(somapply);
		}
		return ds;
	}

	
	public static String reflect(String applyType){
		try {
			Class<?> reflectClass =  Class.forName("com.inspur.cams.sorg.util.ApplyType");
			Field[] field = reflectClass.getDeclaredFields();
			for(int j = 0;j<field.length;j++){
				String value = (String)invokeMethod(reflectClass,field[j].getName());
				if(value.equals(applyType)){
					applyType = (String)invokeMethod(reflectClass,field[j].getName()+"_CN");
					return applyType;
				}
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return applyType;
	}
	
	public  static void main(String args[]){
		String applyType = "000";
		System.out.println(reflect(applyType));
	}
	
	/**
     * 
     * 执行某个Field的getField方法
     * 
     * @param owner 类
     * @param fieldName 类的属性名称
     * @return 
     */
    private static  String invokeMethod(Class<?> owner, String fieldName)
    {
        String value ="";
        //fieldName -> FieldName  
        String methodName = fieldName;
        Method method = null;
        try 
        {
            method = owner.getMethod("get" + methodName);
        } 
        catch (SecurityException e) 
        {

        } 
        catch (NoSuchMethodException e) 
        {
            // e.printStackTrace();
        }
        
        //invoke getMethod
        try
        {
        	value =  method.invoke(owner).toString();
        } 
        catch (Exception e)
        {
            //e.printStackTrace();
        }
		return value;
    }
    /**
     * 查询带有社会组织信息的流程信息
     * @param pset
     * @return
     */
    public DataSet queryOrgan(ParameterSet pset) {
    	List<Integer> typeList = new ArrayList<Integer>();
    	List<String> objsList = new ArrayList<String>();
    	String taskCode = (String)pset.getParameter("TASK_CODE");
    	String sorgId = (String)pset.getParameter("SORG_ID");
    	String sorgCode = (String)pset.getParameter("SORG_CODE");
    	String sorgName = (String)pset.getParameter("SORG_NAME");
    	String sorgType = (String)pset.getParameter("SORG_TYPE");
    	StringBuffer sql = new StringBuffer();
    	sql.append("SELECT * FROM SOM_APPLY A,SOM_ORGAN B WHERE A.SORG_ID=B.SORG_ID ");	    	
//    	sql.append(" AND A.APPLY_TYPE IN (");
//    	sql.append("'"+ApplyType.SOM_GROUP_BUILD+"',");
//    	sql.append("'"+ApplyType.SOM_GROUP_CHANGE+"',");
//    	sql.append("'"+ApplyType.SOM_GROUP_CANCEL+"',");
//    	sql.append("'"+ApplyType.SOM_GROUP_BRANCH_BUILD+"',");
//    	sql.append("'"+ApplyType.SOM_GROUP_BRANCH_CHANGE+"',");
//    	sql.append("'"+ApplyType.SOM_GROUP_BRANCH_CANCEL+"',");
//    	sql.append("'"+ApplyType.SOM_FUND_BUILD+"',");
//    	sql.append("'"+ApplyType.SOM_FUND_CHANGE+"',");
//    	sql.append("'"+ApplyType.SOM_FUND_CANCEL+"',");
//    	sql.append("'"+ApplyType.SOM_FUND_BRANCH_BUILD+"',");
//    	sql.append("'"+ApplyType.SOM_FUND_BRANCH_CHANGE+"',");
//    	sql.append("'"+ApplyType.SOM_FUND_BRANCH_CANCEL+"',");
//    	sql.append("'"+ApplyType.SOM_UNGOV_BUILD_LEGAL+"',");
//    	sql.append("'"+ApplyType.SOM_UNGOV_BUILD_PARTNERSHIP+"',");
//    	sql.append("'"+ApplyType.SOM_UNGOV_BUILD_INDIVIDUAL+"',");
//    	sql.append("'"+ApplyType.SOM_UNGOV_CHANGE+"',");
//    	sql.append("'"+ApplyType.SOM_UNGOV_CANCEL+"',");
//    	sql.append("'"+ApplyType.SOM_CLOSE+"')");
    	if(taskCode != null&&!taskCode.equals("")){
    		sql.append(" AND A.TASK_CODE = ?");
    		typeList.add( Types.VARCHAR );
    		objsList.add(taskCode);
    	}
    	if(sorgId != null&&!sorgId.equals("")){
    		sql.append(" AND A.SORG_ID = ?");
    		typeList.add( Types.VARCHAR );
    		objsList.add(sorgId);
    	}
    	if(sorgCode != null&&!sorgCode.equals("")){
    		sql.append(" AND B.SORG_CODE = ?");
    		typeList.add( Types.VARCHAR );
    		objsList.add(sorgCode);
    	}
    	if(sorgName != null&&!sorgName.equals("")){
    		sql.append(" AND B.CN_NAME = ?");
    		typeList.add( Types.VARCHAR );
    		objsList.add(sorgName);
    	}
    	if(sorgType != null&&!sorgType.equals("")){
    		sql.append(" AND A.SORG_TYPE = ?");
    		typeList.add( Types.VARCHAR );
    		objsList.add(sorgType);
    	}
    	
    	sql.append( " ORDER BY A.ACCEPT_TIME ");
    	int[] types = new int[typeList.size()];
    	for (int i = 0; i < typeList.size(); i++) {
    		types[i] = typeList.get(i);
    	}
    	Object[] args = objsList.toArray(new Object[objsList.size()]);
    	List<Map<String, String>> list = executeQuery(sql.toString(),types,args);
    	
    	DataSet ds = new DataSet();
    	for(int i = 0;i<list.size();i++){
    		SomApply somApply = new SomApply();
    		somApply.setTaskCode(list.get(i).get("TASK_CODE"));
    		somApply.setSorgType(list.get(i).get("SORG_TYPE"));
    		somApply.setSorgName(list.get(i).get("SORG_NAME"));
    		somApply.setSorgId(list.get(i).get("SORG_ID"));
    		String applyType = list.get(i).get("APPLY_TYPE");
    		applyType = reflect(applyType);
    		somApply.setApplyType(applyType);
    		somApply.setIfFinish(list.get(i).get("IF_FINISH").equals("1")?"完成":"未完成");
    		somApply.setAcceptPeopleName(list.get(i).get("ACCEPT_PEOPLE_NAME"));
    		somApply.setAcceptTime(list.get(i).get("ACCEPT_TIME"));
    		somApply.setAcceptDeptName(list.get(i).get("ACCEPT_DEPT_NAME"));
    		somApply.setAuditTime(list.get(i).get("AUDIT_TIME"));
    		ds.addRecord(somApply);
    	}
    	return ds;
    }
    private int getDsStart(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageStart();
		}
		int start = 0;
		if ("0".equals(excelType)) { // 导出当前页
			Integer startExcel = (java.lang.Integer) pset
					.getParameter("startExcel");
			if (startExcel != null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
		return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>2000?2000:limit;
		}
}

