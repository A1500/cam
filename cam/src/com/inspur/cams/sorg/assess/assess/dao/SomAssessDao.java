package com.inspur.cams.sorg.assess.assess.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.assess.assess.data.SomAssess;
import com.inspur.cams.sorg.assess.assess.data.SomAssessAssemble;
import com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig;

/**
 * @title:SomAssessDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public class SomAssessDao extends EntityDao<SomAssess> implements ISomAssessDao{
	 
	public static String QUERY_ALL_SQL ="SELECT * FROM SOM_ASSESS_CONFIG A LEFT JOIN (SELECT A.CONFIG_ID AS C_CONFIG_ID,B.ASSESS_MAKE_SCORE FROM SOM_ASSESS_CONFIG A,SOM_ASSESS_SCORE B WHERE A.CONFIG_ID=B.CONFIG_ID AND B.TASK_CODE=?) C ON	A.CONFIG_ID=C.C_CONFIG_ID WHERE A.ASSESS_TYPE=? ORDER BY SEQ";
 	
	public static List<Map<String, String>> queryList = new ArrayList<Map<String, String>>();
	
	public SomAssessDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomAssess.class;
	}
    public void deleteStruAll() {
		executeUpdate("delete from SomAssess");
	}
    
    public  void initTreeData(String assessType,String taskCode){
 	   int[] types = new int[] { Types.VARCHAR,Types.VARCHAR };
 	   Object[] args = new Object[] { taskCode,assessType};
 	   queryList = executeQuery(QUERY_ALL_SQL, types, args);
    }
    
    public  List<SomAssessAssemble> buildTreeData(String assessType,String taskCode,String parentId,List<SomAssessAssemble> allList){
    	  List<SomAssessAssemble> list = new ArrayList<SomAssessAssemble>();
    	  for(int i = 0;i<queryList.size();i++){
    		  Map<String, String> map = queryList.get(i);
    		  String upId = (String)map.get("UP_ID");
    		  if(upId.equals(parentId)){
//    			  queryList.remove(queryList.get(i));
    			  SomAssessConfig somAssessConfig = buildSomAssessConfig(map);
    			  SomAssessAssemble somAssessAssemble = new SomAssessAssemble();
    			  somAssessAssemble.setThisLevelData(somAssessConfig);
    			  //迭代
    			  List<SomAssessAssemble>  lowerLevelList = buildTreeData(assessType,taskCode,somAssessConfig.getConfigId(),allList);
    			  somAssessAssemble.setLowerLevelAssessAssembleList(lowerLevelList);
    			  list.add(somAssessAssemble);
    		  }
    	  }
    	  allList.addAll(list);
    	  return list;
    }
    
    public  List<SomAssessAssemble> getAllTreeData(String assessType,String taskCode,String parentId){
    	List<SomAssessAssemble> list = new ArrayList<SomAssessAssemble>();
    	buildTreeData(assessType,taskCode,parentId,list);
    	//只保留level为1的
    	Iterator<SomAssessAssemble> it = list.iterator();
    	while(it.hasNext()){
			SomAssessAssemble somAssessAssemble = it.next();
			SomAssessConfig somAssessConfig = somAssessAssemble.getThisLevelData();
			if(!somAssessConfig.getConfigLevel().equals("1")){
				it.remove();
			}
		}
    	return list;
    }
   
   public SomAssessConfig buildSomAssessConfig(Map<String, String> map){
	   SomAssessConfig somAssessConfig = new SomAssessConfig();
	   somAssessConfig.setAssessContent((String)map.get("ASSESS_CONTENT"));
	   somAssessConfig.setAssessScore((String)map.get("ASSESS_SCORE"));
	   somAssessConfig.setConfigId((String)map.get("CONFIG_ID"));
	   somAssessConfig.setConfigLevel((String)map.get("CONFIG_LEVEL"));
	   somAssessConfig.setSeq((String)map.get("SEQ"));
	   somAssessConfig.setAssessType((String)map.get("ASSESS_TYPE"));
	   somAssessConfig.setUpId((String)map.get("UP_ID"));
	   somAssessConfig.setFontSize((String)map.get("FONT_SIZE"));
	   somAssessConfig.setFontStyle((String)map.get("FONT_STYLE"));
	   somAssessConfig.setIfMakeScore((String)map.get("IF_MAKE_SCORE"));
	   somAssessConfig.setIfValid((String)map.get("IF_VALID"));
	   String assessMakeScore = "";
	   if((String)map.get("ASSESS_MAKE_SCORE") != null){
		   assessMakeScore = (String)map.get("ASSESS_MAKE_SCORE");
	   }
	   somAssessConfig.setAssessMakeScore(assessMakeScore);
	   return somAssessConfig;
   }

}
