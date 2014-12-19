package com.inspur.cams.sorg.query.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.query.dao.ISomWorkflowQueryDao;
import com.inspur.cams.sorg.query.data.SomWorkflowQuery;

import java.lang.reflect.Method;

public class SomWorkflowQueryDao extends EntityDao<SomWorkflowQuery> implements ISomWorkflowQueryDao{

	/**
	 * 按照日期查询 已办理过的业务数量
	 */
	public DataSet queryNum(ParameterSet pset){
		DataSet ds = new DataSet();
		String qTime = (String) pset.getParameter("qTime");
		String zTime = (String) pset.getParameter("zTime");
		String organId = (String) pset.getParameter("organId");
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		sql.append("select sa.sorg_type, sa.apply_type, count(sa.apply_type) as num");
		sql.append(" 	from (select wf.primary_key");
		sql.append(" 		from (select t.id,");
		sql.append(" 					 t.primary_key,");
		sql.append("					 t.organ_id,");
		sql.append("					 t.organ_name,");
		sql.append("					 t.create_time,");
		sql.append("					 t.end_time,");
		sql.append("					 t.act_def_id,");
		sql.append("					 t.act_def_name,");
		sql.append("					 t.proc_create_time,");
		sql.append("					 'null' as proc_end_time,");
		sql.append(" 					 t.active_act_def_names,");
		sql.append("					 t.process_type,");
		sql.append("					 t.proc_def_name");
		sql.append("				from wf_yi_ban_task t");
		sql.append("				union all");
		sql.append("			  select t.id,");
		sql.append("					 t.primary_key,");
		sql.append("					 t.organ_id,");
		sql.append("					 t.organ_name,");
		sql.append("					 t.create_time,");
		sql.append("					 t.end_time,");
		sql.append("					 t.act_def_id,");
		sql.append("					 t.act_def_name,");
		sql.append("					 t.proc_create_time,");
		sql.append("					 t.proc_end_time,");
		sql.append("					 'null' as active_act_def_names,");
		sql.append("					 t.process_type,");
		sql.append("					 t.proc_def_name");
		sql.append("			    from wf_end_task t) wf");
		sql.append("		where 1=1");
		if(StringUtils.isNotEmpty(organId)){
			sql.append(" and wf.organ_id = ?");
			typeList.add(Types.VARCHAR);
			objList.add(organId);
		}
		if(StringUtils.isNotEmpty(qTime)){
			sql.append(" and substr(wf.end_time, 0, 8) >= ?");
			typeList.add(Types.VARCHAR);
			objList.add(qTime);
		}
		if(StringUtils.isNotEmpty(zTime)){
			sql.append(" and substr(wf.end_time, 0, 8) <= ?");
			typeList.add(Types.VARCHAR);
			objList.add(zTime);
		}
		sql.append(" 		group by wf.primary_key) wf2,");
		sql.append("	som_apply sa");
		sql.append(" where wf2.primary_key = sa.task_code");
		sql.append(" group by sa.apply_type, sa.sorg_type");
		sql.append(" order by sa.sorg_type,sa.apply_type");
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			
			ds = this.executeDataset(sql.toString(),types,args,true);
			
			if(ds.getCount()>0){
				FieldSet fs = ds.getFieldSet();
				Field f = new Field();
				f.setName("APPLY_TYPE_NAME");
				fs.add(f);
				for (int i = 0; i < ds.getCount(); i++) {
					String sorgType = (String) ds.getRecord(i).get("SORG_TYPE");
					if("J".equals(sorgType)){
						ds.getRecord(i).set("SORG_TYPE", "基金会");
					}
					if("M".equals(sorgType)){
						ds.getRecord(i).set("SORG_TYPE", "民办非企业单位");
					}
					if("S".equals(sorgType)){
						ds.getRecord(i).set("SORG_TYPE", "社会团体");
					}
					String applyType = (String) ds.getRecord(i).get("APPLY_TYPE");
					if(StringUtils.isNotEmpty(applyType)){
						String applyTypeName = reflect(applyType);
						ds.getRecord(i).set("APPLY_TYPE_NAME",applyTypeName);
					}
				}
			}
		}
		return ds;
	}
	
	/**
	 * 按照日期查询 已办理过的指定业务对应的所有社会组织列表
	 */
	public DataSet queryList(ParameterSet pset){
		DataSet ds = new DataSet();
		String qTime = (String) pset.getParameter("qTime");
		String zTime = (String) pset.getParameter("zTime");
		String organId = (String) pset.getParameter("organId");
		String applyType = (String) pset.getParameter("applyType");
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		sql.append("select so.cn_name, wf2.primary_key,rownum as row_num,so.sorg_id");
		sql.append(" from (select wf.primary_key");
		sql.append("  from (select t.id,");
		sql.append("               t.primary_key,");
		sql.append("               t.organ_id,");
		sql.append("               t.organ_name,");
		sql.append("               t.create_time,");
		sql.append("               t.end_time,");
		sql.append("               t.act_def_id,");
		sql.append("               t.act_def_name,");
		sql.append("               t.proc_create_time,");
		sql.append("               'null' as proc_end_time,");
		sql.append("               t.active_act_def_names,");
		sql.append("               t.process_type,");
		sql.append("               t.proc_def_name");
		sql.append("          from wf_yi_ban_task t");
		sql.append("        union all");
		sql.append("        select t.id,");
		sql.append("               t.primary_key,");
		sql.append("               t.organ_id,");
		sql.append("               t.organ_name,");
		sql.append("               t.create_time,");
		sql.append("               t.end_time,");
		sql.append("               t.act_def_id,");
		sql.append("               t.act_def_name,");
		sql.append("               t.proc_create_time,");
		sql.append("               t.proc_end_time,");
		sql.append("               'null' as active_act_def_names,");
		sql.append("               t.process_type,");
		sql.append("               t.proc_def_name");
		sql.append("          from wf_end_task t) wf");
		sql.append(" where 1=1");
		if(StringUtils.isNotEmpty(organId)){
			sql.append(" and wf.organ_id = ?");
			typeList.add(Types.VARCHAR);
			objList.add(organId);
		}
		if(StringUtils.isNotEmpty(qTime)){
			sql.append(" and substr(wf.end_time, 0, 8) >= ?");
			typeList.add(Types.VARCHAR);
			objList.add(qTime);
		}
		if(StringUtils.isNotEmpty(zTime)){
			sql.append(" and substr(wf.end_time, 0, 8) <= ?");
			typeList.add(Types.VARCHAR);
			objList.add(zTime);
		}
		sql.append("   group by wf.primary_key");
		sql.append("   order by wf.primary_key) wf2,");
		sql.append("  som_apply sa,");
		sql.append("  som_organ so");
		sql.append(" where wf2.primary_key = sa.task_code");
		sql.append("   and sa.sorg_id = so.sorg_id");
		if(StringUtils.isNotEmpty(applyType)){
			sql.append(" and sa.apply_type = ?");
			typeList.add(Types.VARCHAR);
			objList.add(applyType);
		}
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			
			ds = this.executeDataset(sql.toString(),types,args,true);
		}
		return ds;
	}
	
	/**
	 * 按照日期查询 已办理过的业务中指定的社会组织对应的所有环节情况
	 */
	public DataSet queryDetail(ParameterSet pset){
		DataSet ds = new DataSet();
		String primaryKey = (String) pset.getParameter("primaryKey");
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		sql.append("select wf.*,sf.opinion_id,sf.opinion,sf.dept_name,sf.organ_name");
		sql.append(" from (select t.id,");
		sql.append("       t.primary_key,");
		sql.append("       t.organ_id as actor_id,");
		sql.append("       t.organ_name as actor_name,");
		sql.append("       t.create_time,");
		sql.append("       t.end_time,");
		sql.append("        t.act_def_id,");
		sql.append("       t.act_def_name,");
		sql.append("       t.proc_create_time,");
		sql.append("       'null' as proc_end_time,");
		sql.append("       t.active_act_def_names,");
		sql.append("       t.process_type,");
		sql.append("       t.proc_def_name");
		sql.append("  from wf_yi_ban_task t");
		sql.append(" union all");
		sql.append(" select t.id,");
		sql.append("       t.primary_key,");
		sql.append("       t.organ_id as actor_id,");
		sql.append("       t.organ_name as actor_name,");
		sql.append("       t.create_time,");
		sql.append("       t.end_time,");
		sql.append("       t.act_def_id,");
		sql.append("       t.act_def_name,");
		sql.append("       t.proc_create_time,");
		sql.append("       t.proc_end_time,");
		sql.append("      'null' as active_act_def_names,");
		sql.append("       t.process_type,");
		sql.append("       t.proc_def_name");
		sql.append("  from wf_end_task t) wf");
		sql.append(" left join som_flow sf on sf.task_code = wf.primary_key");
		sql.append("               and sf.activity = wf.act_def_name");
		sql.append(" where 1=1");
		if(StringUtils.isNotEmpty(primaryKey)){
			sql.append(" and wf.primary_key = ?");
			typeList.add(Types.VARCHAR);
			objList.add(primaryKey);
		}
		sql.append(" order by wf.end_time");
		if(typeList.size()>0&&objList.size()>0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objList.toArray(new Object[objList.size()]);
			
			ds = this.executeDataset(sql.toString(),types,args,true);
		}
		return ds;
	}
	
	/**
	 * 获取ApplyType类中的中文属性值
	 * @param applyType
	 * @return
	 */
	public static String reflect(String applyType){
		try {
			Class<?> reflectClass =  Class.forName("com.inspur.cams.sorg.util.ApplyType");
			java.lang.reflect.Field[] field = reflectClass.getDeclaredFields();
			for(int j = 0;j<field.length;j++){
				String value = (String)invokeMethod(reflectClass,field[j].getName());
				if(value.equals(applyType)){
					return (String)invokeMethod(reflectClass,field[j].getName()+"_CN");
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
	
	@Override
	protected Class<SomWorkflowQuery> getEntityClass() {
		return SomWorkflowQuery.class;
	}

}
