package com.inspur.cams.bpt.excelToTable;

import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;

public class Until {
	protected static final Log logger = LogFactory.getLog(BaseJdbcDao.class);
	public static Object toBean(Record r ,Class c){
		try { 
			Object o=c.newInstance();
			  
		    Map map=r.getData();
		    Set<Entry> set =map.entrySet();
		    
			for (Entry e : set) {
				String key=(String)e.getKey();
				String value =(String)e.getValue();
				String m="_";
				StringBuffer sb = new StringBuffer("set");  
				String name="";
				String[] k=key.split("_");
				for (int i=0;i<k.length;i++) {
					
					String start=k[i].substring(0,1).toUpperCase();
					String end=k[i].substring(1).toLowerCase();
					name+=start+end;
				}
				sb.append(name);
				Method[] md=c.getMethods();
				for (Method method : md) {
					String mname=method.getName();
					if(mname.equals(sb.toString())){
						Type[] ts = method.getGenericParameterTypes(); 
						String xclass = ts[0].toString(); 
						if(value!=null&&!"".equals(value)){
							if(xclass.equals("class java.lang.String")) { 
								method.invoke(o, new Object[]{value}); 
							}else if(xclass.equals("class java.math.BigDecimal")) { 
								
									BigDecimal bd=new BigDecimal(value);
									method.invoke(o, new Object[]{bd});
							} 
						}
						break;
					}
				}
			}
				
			return o;
	    } catch (Exception e) { 
	    	logger.error("Excel_Error",e);
	    	e.printStackTrace();
	    	return null;
	    }     
	}
	
}
